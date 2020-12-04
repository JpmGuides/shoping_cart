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
end
