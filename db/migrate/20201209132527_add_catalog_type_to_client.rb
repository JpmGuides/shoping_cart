class AddCatalogTypeToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :catalog_type, :string
  end
end
