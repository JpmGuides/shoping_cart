require 'rails_helper'

RSpec.describe "ProductsControllers", type: :request do
  let(:client) { create(:client) }
  let(:category) { create(:category, client: client) }

  describe 'POST #create' do
   it "should create product" do
      expect {
        post v1_products_path, params: { product: attributes_for(:product, client: client, category_reference: category.reference), api_key: client.api_key, format: :json }
        expect(response).to be_successful
      }.to change(Product, :count).by(1)
    end

    it "should create product with prices" do
      expect {
        post v1_products_path, params: { product: attributes_for(:product, client: client, category_reference: category.reference, prices_attributes: [attributes_for(:price)]), api_key: client.api_key, format: :json }
        expect(response).to be_successful
      }.to change(Price, :count).by(1)
    end

    it "Should respond bad if a product is not valid and not change categories" do
      invlaid_product_params = {title: 'test'}

      expect {
        post v1_products_path, params: { product: invlaid_product_params, api_key: client.api_key, format: :json }
        expect(response).to be_bad_request
      }.to_not change(Product, :count)
    end
  end

  describe 'DELETE #destroy' do
    it 'Should destroy a product' do
      product = create(:product, client: client, category: category)

      expect {
        delete v1_product_path(id: product.reference), params: { api_key: client.api_key, format: :json }
        expect(response).to be_successful
      }.to change(Product, :count).by(-1)
    end

    it 'Should respond 404 if product does not exists' do
      delete v1_product_path(id: 'not_existing_reference'), params: { api_key: client.api_key, format: :json }
      expect(response).to be_not_found
    end
  end
end
