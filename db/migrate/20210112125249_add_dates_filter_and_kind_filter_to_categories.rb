class AddDatesFilterAndKindFilterToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :dates_filter, :boolean, default: false
    add_column :categories, :kind_filter, :boolean, default: false
    add_column :products, :kind, :string
  end
end
