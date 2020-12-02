class Price < ApplicationRecord
  #
  # Associations
  #
  belongs_to :product, inverse_of: :prices

  #
  # Validations
  #
  validates :product, :price, presence: true
end
