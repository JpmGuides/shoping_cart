class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :number
      t.string :reference
      t.string :key
      t.float :total
      t.integer :client_id
      t.string :currency
      t.string :status
      t.json :invocing_fields_values
      t.string :title
      t.text :description
      t.text :checkout_text
      t.text :checkout_button

      t.timestamps
    end
  end
end
