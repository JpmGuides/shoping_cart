class OrdersController < ApplicationController
  def show
    @order = Order.find_by!(key: params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @order,
        methods: [:invoicing_fields, :logo, :display_title, :display_description, :display_checkout_text, :display_checkout_button],
        except: [:title, :description, :checkout_text, :checkout_button]
      }
    end
  end
end
