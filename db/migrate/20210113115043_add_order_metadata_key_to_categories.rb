class AddOrderMetadataKeyToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :order_metadata_key, :string
  end
end
