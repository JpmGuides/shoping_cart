class OrderItem < ApplicationRecord
  #
  # Associations
  #
  belongs_to :order, inverse_of: :order_items
  #belongs_to :product, inverse_of: :order_items

  #
  # Validations
  #
  validates :order, :title, :price, presence: true

  #
  # Instance methods
  #
  def category_title
    if product_reference.present?
      product = order.client.products.find_by(reference: product_reference)

      if product && product.category
        product.category.title
      else
        ''
      end
    else
      ''
    end
  end
end
