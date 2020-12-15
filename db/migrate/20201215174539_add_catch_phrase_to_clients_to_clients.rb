class AddCatchPhraseToClientsToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :catch_phrase, :string
    add_column :clients, :order_thank_you_text, :string
  end
end
