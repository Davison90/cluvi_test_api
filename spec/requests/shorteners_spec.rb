require 'rails_helper'

RSpec.describe "Shorteners Controller", type: :request do
  describe "GET /show" do
    context 'when the short_code is correct' do
      let(:shortener) { create(:shortener) }

      it 'redirects to url(@short_url)' do
        get "/david/#{shortener.short_code}"

        expect(assigns(:short_url).url).to eq(shortener.url)
        response.should redirect_to(assigns(:short_url).url)
      end
    end

    context 'when short_code is not correct' do
      it 'redirects to url(@short_url)' do
        get "/david/ashdm5"

        payload = JSON.parse(response.body)

        expect(payload).not_to be_empty
        expect(payload['error']).to eq('Not Found')
        expect(response).to have_http_status(:not_found)
      end
    end
  end

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
