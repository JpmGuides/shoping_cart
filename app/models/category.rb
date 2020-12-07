class Category < ApplicationRecord
  has_one_attached :image

  #
  # Associations
  #
  belongs_to :client, inverse_of: :categories
  has_many :products, foreign_key: :category_reference, primary_key: :reference

  #
  # Validations
  #
  validates :client, :title, :description, :reference, presence: true
  validates :reference, uniqueness: { scope: :client_id }

  #
  # Instance methods
  #
  def image_url
    if image.attached?
      if Rails.env.production?
        image.service_url
      else
        Rails.application.routes.url_helpers.url_for(image)
      end
    else
      nil
    end
  end

  def attributes
    super.merge({ image_url: image_url })
  end
end
