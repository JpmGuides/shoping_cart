class AddRequestReceivedReferenceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :request_received_reference, :integer
  end
end
