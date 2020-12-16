class AddDeliveryTitleToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :delivery_title, :string
  end
end
