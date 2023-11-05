require 'rails_helper'

RSpec.describe "Invoices", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/invoices/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/invoices/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/invoices/show"
      expect(response).to have_http_status(:success)
    end
  end

end
