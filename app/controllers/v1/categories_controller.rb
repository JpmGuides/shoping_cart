class V1::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate_from_api_token

  def create
    category_ids = []

    ActiveRecord::Base.transaction do
      categories_params[:categories].each_with_index do |category_params, index|
        category = @client.categories.find_or_initialize_by(reference: category_params[:reference])
        base_64_data = category_params.delete(:image_base_64)

        if base_64_data.present?
          category.image = {
            io: StringIO.new(Base64.decode64(base_64_data)),
            content_type: 'image/jpeg',
            filename: 'image.jpg'
          }
        end

        category.update!(category_params.merge(position: index))
        category_ids << category.id
      end

      @client.categories.where.not(id: category_ids).destroy_all
    end

    respond_to do |format|
      format.json { head :ok }
    end
  rescue ActiveRecord::RecordInvalid
    head :bad_request
  end

  protected

  def categories_params
    params.permit(categories: [:title, :description, :reference, :days_count, :image_base_64,
      :dates_filter, :kind_filter, :button_text, :dates_filter_label, :kind_filter_label,
      :order_metadata_key, :online_flag, :duration_filter, :duration_filter_label,
      :age_filter, :age_filter_label])
  end
end
