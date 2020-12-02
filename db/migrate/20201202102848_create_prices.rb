class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :prices do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.float :price
      t.integer :product_id

      t.timestamps
    end
  end
end
