class Product < ApplicationRecord
  has_one_attached :image

  #
  # Associations
  #
  belongs_to :category, foreign_key: :category_reference, primary_key: :reference
  belongs_to :client, inverse_of: :products

  #
  # Validations
  #
  validates :client, :category, :title, :description, :reference, presence: true
  validates :reference, uniqueness: { scope: :client_id }
end
