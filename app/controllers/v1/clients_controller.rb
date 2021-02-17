class V1::ClientsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate_from_api_token

  def update
    @client.update(client_params)

    respond_to do |format|
      format.json { head :ok }
    end
  rescue ActiveRecord::RecordInvalid
    head :bad_request
  end

  protected

  def client_params
    params.permit(
      :order_title, :order_description, :order_checkout_text, :order_checkout_button,
      :order_cart_title, :order_address_title, :order_thank_you_text, :order_thank_you_title,
      :order_delivery_title, :catalog_title, :catch_phrase, :general_conditions_checkbox_label,
      :general_conditions_page_html, :six_saferpay_customer_id, :six_saferpay_terminal_id,
      :six_saferpay_username, :six_saferpay_password
    )
  end
end
