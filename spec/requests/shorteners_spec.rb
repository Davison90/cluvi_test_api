require 'rails_helper'

RSpec.describe "Shorteners Controller", type: :request do
  describe "POST /create" do
    before do
      allow(AlexaService).to receive(:cal_rank).and_return(100)
    end

    context "when url is correct" do
      req_payload = { url: Faker::Internet.url }

      it 'should return created' do
        post '/shorteners', params: req_payload

        payload = JSON.parse(response.body)

        expect(payload).not_to be_empty
        expect(response).to have_http_status(:ok)
      end
    end

    context "when url is incorrect" do
      # URL must start with http or https
      req_payload = { url: 'htt://bashirian-stark.biz/joye_schulist' }

      it 'should return error' do
        post '/shorteners', params: req_payload

        payload = JSON.parse(response.body)

        expect(payload).not_to be_empty
        expect(payload['error']).to eq('Validation failed: Url is invalid')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
