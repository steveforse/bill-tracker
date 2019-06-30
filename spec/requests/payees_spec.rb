require 'rails_helper'

RSpec.describe "Payees", type: :request do
  describe "GET /payees" do
    it "works! (now write some real specs)" do
      get payees_path
      expect(response).to have_http_status(200)
    end
  end
end
