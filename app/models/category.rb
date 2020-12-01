class Category < ApplicationRecord
  has_one_attached :image

  #
  # Associations
  #
  belongs_to :client, inverse_of: :categories

  #
  # Validations
  #
  validates :client, :title, :description, presence: true
end
