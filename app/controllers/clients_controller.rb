class ClientsController < ApplicationController
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @client, include: [:categories], methods: [:logo_url] }
    end
  end

  protected

  def order_params
    params[:order].permit!
  end
end
