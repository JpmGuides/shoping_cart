class AddOrderTextFieldsToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :order_title, :string
    add_column :clients, :order_description, :string
    add_column :clients, :order_checkout_text, :string
    add_column :clients, :order_checkout_button, :string
    rename_column :clients, :invoicing_fileds, :invoicing_fields
  end
end
