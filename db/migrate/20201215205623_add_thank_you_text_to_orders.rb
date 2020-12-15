class AddThankYouTextToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :thank_you_text, :string
  end
end
