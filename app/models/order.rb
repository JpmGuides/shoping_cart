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
  before_create :set_currency
  after_update :post_to_webhook_if_status_changed_to_accepted

  #
  # Extensions
  #
  accepts_nested_attributes_for :order_items

  #
  # Validations
  #
  validates :client, :reference, presence: true

  #
  # Instance methods
  #
  def invoicing_fields
    client.invoicing_fields
  end

  def delivery_fields
    client.delivery_fields
  end

  def logo
    client.logo_url
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

  def display_cart_title
    if cart_title.present?
      cart_title
    elsif client.order_cart_title.present?
      client.order_cart_title
    else
      "Votre panier d'achat"
    end
  end

  def display_address_title
    if address_title.present?
      address_title
    elsif client.order_address_title.present?
      client.order_address_title
    else
      "Adresse de facturation"
    end
  end

  def display_delivery_title
    if delivery_title.present?
      delivery_title
    elsif client.order_delivery_title.present?
      client.order_delivery_title
    else
      "Adresse de livraison"
    end
  end

  def display_thank_you_text
    if thank_you_text.present?
      thank_you_text
    elsif client.order_thank_you_text.present?
      client.order_thank_you_text
    else
      "Les produits seront livrés dans les plus brefs délais"
    end
  end

  def display_thank_you_title
    if thank_you_title.present?
      thank_you_title
    elsif client.order_thank_you_title.present?
      client.order_thank_you_title
    else
      "Merci pour votre commande"
    end
  end

  def post_to_webhook
    puts "posting response to webhook"
    return unless client.webhook_url.present?

    uri = URI.parse(client.webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    request = Net::HTTP::Post.new(uri.path)
    request.basic_auth(client.basic_auth_username, client.basic_auth_password) if client.basic_auth_username.present? && client.basic_auth_password.present?
    request.body = json_for_webhook.to_json
    request['Content-Type'] = 'application/json'

    http.request(request)
  end

  def json_for_webhook
    h = invocing_fields_values.map {|v| [v['key'], v['value']]}.to_h
    h.merge!('reference' => reference)
    items_values = []
    order_items.each do |item|
      value = (item.order_fields_values || []).map {|v| [v['key'], v['value']]}.to_h
      value.merge!('reference' => (item.product_reference || item.id))
      items_values << value
    end
    h.merge('items' => items_values)
  end

  private

  def post_to_webhook_if_status_changed_to_accepted
    post_to_webhook if previous_changes['status'].present? && status == 'accepted'
  end

  def set_key
    self.key = generate_key
  end

  def generate_key
    token = SecureRandom.hex(10)

    while Order.where(key: token).exists? do
      token = SecureRandom.hex(10)
    end

    token
  end

  def set_currency
    self.currency == client.currency
  end
end
