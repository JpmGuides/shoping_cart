class AddDurationFilterAndAgeFilterToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :duration_filter, :boolean
    add_column :categories, :duration_filter_label, :boolean
    add_column :categories, :age_filter, :boolean
    add_column :categories, :age_filter_label, :boolean
  end
end
