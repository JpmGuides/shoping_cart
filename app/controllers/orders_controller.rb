class OrdersController < ApplicationController
  def show
    @order = Order.find_by!(key: params[:id])
    @client = @order.client

    respond_to do |format|
      format.html
      format.json { render json: @order,
        include: { order_items: { except: [:created_at, :updated_at], methods: [:category_title] } },
        methods: [
          :invoicing_fields, :delivery_fields, :logo, :display_title, :display_description, :display_checkout_text,
          :display_checkout_button, :display_cart_title, :display_address_title,
          :display_thank_you_text, :display_thank_you_title, :display_delivery_title,
          :client_name, :has_online_payment, :general_conditions_checkbox_label,
          :general_conditions_url
        ],
        except: [
          :title, :description, :checkout_text, :checkout_button, :cart_title,
          :address_title, :thank_you_text, :thank_you_title, :delivery_title,
          :created_at, :updated_at, :disable_online_payment, :six_saferpay_transaction_id
        ]
      }
    end
  end

  def update
    @order = Order.find_by!(key: params[:id])
    @client = @order.client
    valid_params = order_params.to_h
    order_items_params = valid_params.delete('order_items')

    order_items_params.each do |k, v|
      next unless @order.order_items.where(id: k).exists?

      item = @order.order_items.find(k)
      item.update(order_fields_values: v.map{ |k,v| { key: k, value: v } })
    end

    if @order.has_online_payment
      @order.update(invocing_fields_values: valid_params.map{ |k,v| { key: k, value: v } }, status: 'waiting_for_payment')

      redirect_to @order.get_saferpay_redirect_url
    else
      @order.update(invocing_fields_values: valid_params.map{ |k,v| { key: k, value: v } }, status: 'accepted')
      cookies.delete :'cart-key'

      respond_to do |format|
        format.html { render :show }
      end
    end
  end

  def create
    @client = Client.find(params[:client_id])
    @order = @client.orders.find_by(key: order_params['key'])

    if order_params['key'].present? && @order.present? && @order.status != 'accepted'
      @order.order_items.delete_all
      @order.update(start_date: order_params['start_date'])
    else
      @order = @client.orders.create(currency: @client.currency, start_date: order_params['start_date'] )
      cookies[:'cart-key'] = {
        value: @order.key
      }
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

  def add_product
    @client = Client.find(params[:client_id])
    @order = @client.orders.find_by(key: order_params['key'])

    unless order_params['key'].present? && @order.present? && @order.status != 'accepted'
      @order = @client.orders.create(currency: @client.currency, start_date: order_params['start_date'] )
      cookies[:'cart-key'] = {
        value: @order.key
      }
    end

    order_params['products'].each do |product_params|
      product = Product.find(product_params['id'])
      price = product.price_for_date(order_params['start_date'])

      @order.order_items.create!(title: product.title, description: product.description, price: price, order_fields: product.order_fields, product_reference: product.reference, start_date: order_params['start_date'])
    end

    respond_to do |format|
      format.json { render json: @order, only: [:key], include: { order_items: { except: [:created_at, :updated_at], methods: [:category_title] } } }
    end
  end

  def remove_product
    @order = Order.find_by(key: params[:id])

    if @order.present?
      @order.order_items.find(params[:item_id]).destroy
    end

    respond_to do |format|
      format.json { render json: @order.order_items, except: [:created_at, :updated_at], methods: [:category_title] }
    end
  end

  def payment_success
    @order = Order.find_by(key: params[:id])
    @order.saferpay_capture_payment

    @order.update(status: 'accepted')
    cookies.delete :'cart-key'

    redirect_to action: 'show', id: @order.key
  end

  def payment_fail
    @order = Order.find_by(key: params[:id])

    @order.update(status: 'payment_fail')

    redirect_to action: 'show', id: @order.key
  end

  protected

  def order_params
    params[:order].permit!
  end
end
