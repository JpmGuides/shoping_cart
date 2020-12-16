class AddCatalogTitleToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :catalog_title, :string
  end
end
