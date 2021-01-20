class AddSixSaferpayTokenToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :six_saferpay_token, :string
    add_column :orders, :six_saferpay_transaction_reference, :string
  end
end
