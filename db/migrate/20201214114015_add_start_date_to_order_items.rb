class AddStartDateToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :start_date, :date
  end
end
