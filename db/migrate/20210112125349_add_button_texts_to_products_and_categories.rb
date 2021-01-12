class AddButtonTextsToProductsAndCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :button_text, :string
    add_column :products, :button_prefix_text, :string
  end
end
