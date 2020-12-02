class OrdersController < ApplicationController
  def show
    @order = Order.find_by!(key: params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @order, methods: [:invoicing_fileds] }
    end
  end
end
