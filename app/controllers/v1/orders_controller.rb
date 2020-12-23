class V1::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate_from_api_token

  def create
    valid_params = order_params
    order = @client.orders.find_or_initialize_by(reference: valid_params[:reference])
    order.order_items.destroy_all if valid_params[:order_items_attributes].present?
    order.update!(valid_params)

    respond_to do |format|
      format.json { render json: order, only: [:key] }
    end
  rescue ActiveRecord::RecordInvalid
    head :bad_request
  end

  protected

  def order_params
    params.require(:order).permit(
      :number, :reference, :status, :title, :description, :checkout_text, :checkout_button,
      :cart_title, :address_title, :thank_you_text, :thank_you_title, :delivery_title,
      order_items_attributes: [
        :title, :description, :price, :product_reference,
        order_fields: [:name, :key, :type, :required],
        order_fields_values: [:key, :value]
      ]
    )
  end
end
