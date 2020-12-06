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
end
