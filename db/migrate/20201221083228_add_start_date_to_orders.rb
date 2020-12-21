class AddStartDateToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :start_date, :date
  end
end
