class DrinkOffersController < ApplicationController
  layout -> { request.xhr? ? false : 'application' }

  def new
    dealer
    @drink_offer = DrinkOffer.new
    @drink_offer.status = :available
    set_breadcrumbs!
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

  def set_breadcrumbs!
    @breadcrumbs = [
      [ '/', 'Mate'],
      [ '/mate/in', 'Deutschland'],
    ]
    if @dealer.postcode
      @breadcrumbs << [ view_context.location_url(federal_state: @dealer.federal_state), @dealer.federal_state.name ]
      @breadcrumbs << [ view_context.location_url(federal_state: @dealer.federal_state, postcode: @dealer.postcode), @dealer.postcode.name ]
    end
    @breadcrumbs << [ '', @dealer.name ]
  end
end
