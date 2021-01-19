class AddSixSaferpayAuthenticationParamsToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :six_saferpay_customer_id, :string
    add_column :clients, :six_saferpay_terminal_id, :string
    add_column :clients, :six_saferpay_username, :string
    add_column :clients, :six_saferpay_password, :string
  end
end
