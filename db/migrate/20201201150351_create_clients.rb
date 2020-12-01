class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :api_key
      t.hstore :preferences
      t.json :invoicing_fileds
      t.string :webhook
      t.string :webhook_api_key
      t.string :currency

      t.timestamps
    end
  end
end
