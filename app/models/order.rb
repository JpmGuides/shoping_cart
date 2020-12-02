class Order < ApplicationRecord
  #
  # Associations
  #
  belongs_to :client, inverse_of: :orders

  #
  # Callbacks
  #
  before_validation :set_key, on: :create

  #
  # Instance methods
  #

  def invoicing_fields
    client.invoicing_fields
  end

  private

  def set_key
    self.key = generate_key
  end

  def generate_key
    token = SecureRandom.hex(25)

    while Order.where(key: token).exists? do
      token = SecureRandom.hex(25)
    end

    token
  end
end
