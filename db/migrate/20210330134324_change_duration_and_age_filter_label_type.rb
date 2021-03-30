class ChangeDurationAndAgeFilterLabelType < ActiveRecord::Migration[6.0]
  def change
    change_column :categories, :duration_filter_label, :string
    change_column :categories, :age_filter_label, :string
  end
end
