class Product < ApplicationRecord
  has_one_attached :image

  #
  # Associations
  #
  belongs_to :category, foreign_key: :category_reference, primary_key: :reference
  belongs_to :client, inverse_of: :products
  has_many :prices, inverse_of: :product, dependent: :delete_all

  #
  # Validations
  #
  validates :client, :category, :title, :description, :reference, presence: true
  validates :reference, uniqueness: { scope: :client_id }

  #
  # Extensions
  #
  accepts_nested_attributes_for :prices

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
