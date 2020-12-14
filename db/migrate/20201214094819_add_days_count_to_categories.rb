class AddDaysCountToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :days_count, :integer
  end
end
