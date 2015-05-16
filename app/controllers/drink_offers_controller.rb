class DrinkOffersController < ApplicationController
  layout -> { request.xhr? ? false : 'application' }

  def new
    @drink_offer = DrinkOffer.new
    @drink_offer.status = :available
  end

  def create
    @drink_offer = DrinkOffer.new(drink_offer_params)
    @drink_offer.dealer = dealer
    if @drink_offer.save
      redirect_to dealer, notice: 'Information aktualisiert. Vielen Dank für die Eingabe!'
    else
      render :new
    end
  end

  protected

  def drink_offer_params
    params.require(:drink_offer).permit(:drink_id, :status)
  end

  def dealer
    @dealer ||= Dealer.find(params[:dealer_id])
  end
  helper_method :dealer
end
