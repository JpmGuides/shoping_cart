class AddOrderThankYouTitleToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :order_thank_you_title, :string
  end
end
