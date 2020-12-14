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

  def price_for_date(start_date = nil)
    final_price = 0
    if start_date.present?
      start_date = Date.parse(start_date)
      if category.days_count.present?
        (start_date..(start_date + category.days_count.days)).each do |date|
          final_price += prices.where('start_date <= ? AND end_date >= ?', date, date).first.price / category.days_count
        end
      else
        final_price = prices.where('start_date <= ? AND end_date >= ?', start_date, start_date).first.price
      end
    else
      final_price = prices.first.price
    end

    final_price
  end
end
