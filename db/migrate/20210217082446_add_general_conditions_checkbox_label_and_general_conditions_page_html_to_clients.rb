class AddGeneralConditionsCheckboxLabelAndGeneralConditionsPageHtmlToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :general_conditions_checkbox_label, :string
    add_column :clients, :general_conditions_page_html, :text
  end
end
