require 'rails_helper'

describe "Api::HealthCheck", type: :request do
  describe "GET /index" do
    it "returns a status code of 200" do
      get api__healthcheck_path
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json['message']).to eq 'OK'

      # assert_response_schema_confirm(200)
    end
  end
end
