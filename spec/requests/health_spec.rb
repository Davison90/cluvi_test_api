require 'rails_helper'

RSpec.describe "Health", type: :request do
  describe "GET /health" do
    it 'should return status OK' do
      get '/health'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['api']).to eq('OK')
    end
  end
end
