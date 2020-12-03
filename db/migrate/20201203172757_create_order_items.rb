class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.string :title
      t.text :description
      t.json :order_fields
      t.json :order_fields_values
      t.integer :order_id
      t.float :price

      t.timestamps
    end
  end
end
