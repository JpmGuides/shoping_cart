class V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate_from_api_token

  def create
    valid_params = product_params
    product = @client.products.find_or_initialize_by(reference: valid_params[:reference])
    base_64_data = valid_params.delete(:image_base_64)

    product.prices.destroy_all if valid_params[:prices_attributes].present?
    product.update!(valid_params)

    if base_64_data.present?
      product.image = {
        io: StringIO.new(Base64.decode64(base_64_data)),
        content_type: 'image/jpeg',
        filename: 'image.jpg'
      }
    end

    respond_to do |format|
      format.json { head :ok }
    end
  rescue ActiveRecord::RecordInvalid
    head :bad_request
  end

  def destroy
    product = @client.products.find_by!(reference: params[:id])

    product.destroy
  end

  protected

  def product_params
    params.require(:product).permit(
      :title, :description, :reference, :image_base_64, :display, :status, :start_date,
      :end_date, :category_reference, :kind, :button_prefix_text,
      order_fields: [:name, :key, :type, :required, values: {}],
      prices_attributes: [:name, :start_date, :end_date, :price],
      metadata: {}
    )
  end
end
