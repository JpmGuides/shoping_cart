class AddSixSaferpayTransactionIdAndDisableOnlinePaymentToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :six_saferpay_transaction_id, :string
    add_column :orders, :disable_online_payment, :boolean, default: false
  end
end
