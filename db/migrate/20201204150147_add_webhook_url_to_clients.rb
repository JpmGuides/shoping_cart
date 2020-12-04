class AddWebhookUrlToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :webhook_url, :string
  end
end
