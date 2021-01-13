class ClientsController < ApplicationController
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @client, include: [categories: { include: [products: { include: :prices }] }], methods: [:logo_url, :background_image_url], except: [ :webhook_url, :basic_auth_username, :basic_auth_password, :webhook_api_key, :invoicing_fields ] }
    end
  end

  protected

  def order_params
    params[:order].permit!
  end
end
