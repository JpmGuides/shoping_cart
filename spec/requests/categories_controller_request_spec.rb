require 'rails_helper'

RSpec.describe "CategoriesControllers", type: :request do
  let(:client) { create(:client) }

  it "should create categories" do
    category_params = [attributes_for(:category, client: client), attributes_for(:category, client: client)]

    expect {
      post v1_categories_path, params: { categories: category_params, api_key: client.api_key, format: :json }
      expect(response).to be_successful
    }.to change(Category, :count).by(2)
  end

  it "should delete categories that are not in the list" do
    category = create(:category, reference: 'test_params_deletion', client: client)
    category_params = [attributes_for(:category, client: client), attributes_for(:category, client: client)]

    post v1_categories_path, params: { categories: category_params, api_key: client.api_key, format: :json }

    expect(Category.where(id: category.id).exists?).to be_falsy
  end

  it "Should respond bad if a category is not valid and not change categories" do
    create(:category, reference: 'test_params_deletion', client: client)
    invlaid_category_params = [{title: 'test'}]

    expect {
      post v1_categories_path, params: { categories: invlaid_category_params, api_key: client.api_key, format: :json }
      expect(response).to be_bad_request
    }.to_not change(Category, :count)
  end
end
