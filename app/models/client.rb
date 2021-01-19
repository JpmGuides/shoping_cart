class Client < ApplicationRecord
  has_one_attached :logo
  has_one_attached :background_image

  #
  # Associations
  #
  has_many :categories, -> { order(:position) }, inverse_of: :client
  has_many :products, inverse_of: :client
  has_many :orders, inverse_of: :client

  #
  # Validations
  #
  validates :name, :api_key, presence: true
  validates :api_key, uniqueness: true

  #
  # Callbacks
  #
  before_validation :set_api_key, on: :create

  #
  # Instance methods
  #
  def logo_url
    if logo.attached?
      if Rails.env.production?
        logo.service_url
      else
        Rails.application.routes.url_helpers.url_for(logo)
      end
    else
      nil
    end
  end

  def background_image_url
    if background_image.attached?
      if Rails.env.production?
        background_image.service_url
      else
        Rails.application.routes.url_helpers.url_for(background_image)
      end
    else
      nil
    end
  end

  def has_online_payment?
    six_saferpay_customer_id.present? &&
    six_saferpay_terminal_id.present? &&
    six_saferpay_username.present? &&
    six_saferpay_password.present?
  end

  def base_domain
    if Rails.env.production?
      "https://#{subdomain.present? ? "#{subdomain}." : ''}bookexperience.ch"
    else
      "http://#{subdomain.present? ? "#{subdomain}." : ''}localhost:3000"
    end
  end

  private

  def set_api_key
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
