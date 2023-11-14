require 'rails_helper'

RSpec.describe "Decks", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/decks/new"
      expect(response).to have_http_status(:success)
    end
  end

end
