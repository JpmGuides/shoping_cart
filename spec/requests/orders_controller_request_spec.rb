require 'rails_helper'

RSpec.describe "Orders", type: :request do

  describe "GET /show" do
    let(:order) { create(:order) }

    it "returns http success with html" do
      get "/orders/#{order.key}"
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end

    it "returns http success with json" do
      get "/orders/#{order.key}.json"
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

end
