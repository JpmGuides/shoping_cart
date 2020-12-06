class AddCartTitleAndAddressTitleToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :cart_title, :string
    add_column :orders, :address_title, :string
  end
end
