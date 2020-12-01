class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.integer :client_id
      t.string :reference

      t.timestamps
    end
  end
end
