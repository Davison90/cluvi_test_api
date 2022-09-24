class ShortenersController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message }, status: :unprocessable_entity
  end

  def create
    rank = AlexaService.cal_rank(params[:url]).to_i
    url = Shortener.create!(url: params[:url], alexa_rank: rank)

    render json: url, status: :ok
  end
end
