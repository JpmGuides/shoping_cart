class AddDeliveryFieldsAndOrderDeliveryTitleToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :delivery_fields, :json
    add_column :clients, :order_delivery_title, :string
  end
end
