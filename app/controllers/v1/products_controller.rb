class V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate_from_api_token

  def create
    valid_params = product_params
    product = @client.products.find_or_initialize_by(reference: valid_params[:reference])
    base_64_data = valid_params.delete(:image_base_64)

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

  protected

  def product_params
    params.require(:product).permit(
      :title, :description, :reference, :image_base_64, :display, :status, :start_date,
      :end_date, :category_reference, order_fields: [:name, :type, :required]
    )
  end
end
