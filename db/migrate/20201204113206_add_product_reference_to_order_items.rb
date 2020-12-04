class AddProductReferenceToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :product_reference, :string
  end
end
