class AddBasicAuthUsernameAndBasicAuthPasswordToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :basic_auth_username, :string
    add_column :clients, :basic_auth_password, :string
  end
end
