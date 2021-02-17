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
  end
end
