class AddAutoRepostOrdersToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :auto_repost_orders, :boolean, default: false
  end
end
