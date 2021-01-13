class AddDatesFilterLabelAndKindFilterLabelToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :dates_filter_label, :string
    add_column :categories, :kind_filter_label, :string
  end
end
