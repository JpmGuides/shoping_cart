class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :status
      t.boolean :display
      t.date :start_date
      t.date :end_date
      t.json :order_fields
      t.string :reference
      t.string :category_reference
      t.integer :client_id

      t.timestamps
    end
  end
end
