class AddDateSelectChooseTextToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :date_select_choose_text, :string
  end
end
