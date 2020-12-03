class Product < ApplicationRecord
  has_one_attached :image

  #
  # Associations
  #
  belongs_to :category, foreign_key: :category_reference, primary_key: :reference
  belongs_to :client, inverse_of: :products
  has_many :prices, inverse_of: :product, dependent: :delete_all
  has_many :order_items, inverse_of: :product

  #
  # Validations
  #
  validates :client, :category, :title, :description, :reference, presence: true
  validates :reference, uniqueness: { scope: :client_id }

  #
  # Extensions
  #
  accepts_nested_attributes_for :prices
end
