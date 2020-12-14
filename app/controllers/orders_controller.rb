class OrdersController < ApplicationController
  def show
    @order = Order.find_by!(key: params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @order,
        include: { order_items: { except: [:created_at, :updated_at] } },
        methods: [:invoicing_fields, :logo, :display_title, :display_description, :display_checkout_text, :display_checkout_button, :display_cart_title, :display_address_title],
        except: [:title, :description, :checkout_text, :checkout_button, :created_at, :updated_at]
      }
    end
  end

  def update
    @order = Order.find_by!(key: params[:id])
    valid_params = order_params.to_h
    order_items_params = valid_params.delete('order_items')

    order_items_params.each do |k, v|
      next unless @order.order_items.where(id: k).exists?

      item = @order.order_items.find(k)
      item.update(order_fields_values: v.map{ |k,v| { key: k, value: v } })
    end

    @order.update(invocing_fields_values: valid_params.map{ |k,v| { key: k, value: v } }, status: 'accepted')
    cookies.delete :'cart-key'

    respond_to do |format|
      format.html { render :show }
    end
  end

  def create
    @client = Client.find(params[:client_id])

    if order_params['key'].present?
      @order = @client.orders.find_by(key: order_params['key'])
      @order.order_items.delete_all
    else
      @order = @client.orders.create(reference: DateTime.now.to_i.to_s)
    end

    order_params['products'].each do |product_params|
      product = Product.find(product_params['id'])
      price = product.price_for_date(order_params['start_date'])

      if product_params['quantity'].present?
        product_params['quantity'].times do
          @order.order_items.create!(title: product.title, description: product.description, price: price, order_fields: product.order_fields, product_reference: product.reference, start_date: order_params['start_date'])
        end
      end
    end

    respond_to do |format|
      format.json { render json: @order, only: [:key] }
    end
  end

  protected

  def order_params
    params[:order].permit!
  end
end
