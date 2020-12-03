class Order < ApplicationRecord
  #
  # Associations
  #
  belongs_to :client, inverse_of: :orders
  has_many :order_items, inverse_of: :order

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

  def logo
    if client.logo.attached?
      Rails.application.routes.url_helpers.url_for(client.logo)
    else
      nil
    end
  end

  def display_title
    if title.present?
      title
    elsif client.order_title.present?
      client.order_title
    else
      "Votre Offre"
    end
  end

  def display_description
    if description.present?
      description
    elsif client.order_description.present?
      client.order_description
    else
      "Voici la liste des entrées de votre panier d'achat"
    end
  end

  def display_checkout_text
    if checkout_text.present?
      checkout_text
    elsif client.order_checkout_text.present?
      client.order_checkout_text
    else
      "Nous vous remercions d'avance pour votre achat, Le payment vous sera demandé dans un second temps"
    end
  end

  def display_checkout_button
    if checkout_button.present?
      checkout_button
    elsif client.order_checkout_button.present?
      client.order_checkout_button
    else
      "Commander"
    end
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
