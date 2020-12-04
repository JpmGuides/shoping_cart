require 'rails_helper'

RSpec.describe "V1::OrderControllers", type: :request do
  let(:client) { create(:client) }

  describe 'POST #create' do
   it "should create Order" do
      expect {
        post v1_orders_path, params: { order: attributes_for(:order, client: client, order_items_attributes: [attributes_for(:order_item)]), api_key: client.api_key, format: :json }
        expect(response).to be_successful
      }.to change(Order, :count).by(1)
    end

    it "should create order with order items" do
      expect {
        post v1_orders_path, params: { order: attributes_for(:order, client: client, order_items_attributes: [attributes_for(:order_item)]), api_key: client.api_key, format: :json }
        expect(response).to be_successful
      }.to change(OrderItem, :count).by(1)
    end

    it "Should respond bad if an order is not valid and not change categories" do
      invalid_order_params = {title: 'test'}

      expect {
        post v1_orders_path, params: { order: invalid_order_params, api_key: client.api_key, format: :json }
        expect(response).to be_bad_request
      }.to_not change(Order, :count)
    end
  end
end
