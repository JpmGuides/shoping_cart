class AddOnlineFlagToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :online_flag, :boolean, default: true
  end
end
