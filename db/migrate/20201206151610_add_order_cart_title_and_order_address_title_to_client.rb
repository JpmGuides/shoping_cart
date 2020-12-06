class AddOrderCartTitleAndOrderAddressTitleToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :order_cart_title, :string
    add_column :clients, :order_address_title, :string
  end
end
