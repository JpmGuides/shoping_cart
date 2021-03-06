class ClientsController < ApplicationController
  def show
    @client = Client.find(params[:id] || params[:client_id])
    @category_id =  params[:category_id]

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @client, include: [online_categories: { root: 'categories', include: [products: { include: :prices }] }], methods: [:logo_url, :background_image_url], except: [ :webhook_url, :basic_auth_username, :basic_auth_password, :webhook_api_key, :invoicing_fields ] }
    end
  end

  def general_conditions
    @client = Client.find(params[:client_id])
  end

  protected

  def order_params
    params[:order].permit!
  end
end
