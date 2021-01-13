class AddMetadataToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :metadata, :hstore
  end
end
