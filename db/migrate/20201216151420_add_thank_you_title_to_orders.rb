class AddThankYouTitleToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :thank_you_title, :string
  end
end
