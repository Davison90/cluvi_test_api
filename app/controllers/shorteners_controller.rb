class ShortenersController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def show
    @short_url = Shortener.find_by_short_code(params[:short_code])
    if @short_url
      @short_url.update!(counter: @short_url.counter + 1)
      redirect_to @short_url.url, allow_other_host: true
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end

  def create
    rank = AlexaService.cal_rank(params[:url]).to_i
    short_url = Shortener.create!(url: params[:url], alexa_rank: rank)

    render json: short_url, status: :ok
  end
end
