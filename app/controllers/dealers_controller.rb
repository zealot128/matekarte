class DealersController < ApplicationController
  def index
    dealers = Dealer.
      select('ARRAY(select distinct(drink_id) from drink_offers where drink_offers.dealer_id = dealers.id) as instant_drink_ids').
      near( [params[:lat].to_f, params[:lon].to_f], 100)

    render json: dealers
  end
end
