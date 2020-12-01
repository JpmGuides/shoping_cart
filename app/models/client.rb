class Client < ApplicationRecord
  has_one_attached :logo
  has_one_attached :background_image

  #
  # Validations
  #
  validates :name, :api_key, presence: true
  validates :api_key, uniqueness: true

  #
  # Callbacks
  #
  before_validation :set_api_key, on: :create

  private

  def set_api_key
    puts 'hello before create'
    self.api_key = generate_api_key
  end

  def generate_api_key
    token = SecureRandom.hex(25)

    while Client.where(api_key: token).exists? do
      token = SecureRandom.hex(25)
    end

    token
  end
end
