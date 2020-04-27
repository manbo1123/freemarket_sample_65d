require 'rails_helper'

RSpec.describe "Mypage::Exhibitions", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/mypage/exhibition/index"
      expect(response).to have_http_status(:success)
    end
  end

end
