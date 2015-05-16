class DealersController < ApplicationController
  def index
    dealers = Dealer.near( [params[:lat].to_f, params[:lon].to_f], 100)
    render json: dealers
  end

  def show
    @dealer = Dealer.find(params[:id])
    @drink_offers = @dealer.drink_offers.newest_groups
    render layout: !request.xhr?
  end

  def new
  end
end
