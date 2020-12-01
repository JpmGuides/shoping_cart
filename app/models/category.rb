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
end
