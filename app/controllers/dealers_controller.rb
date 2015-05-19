class DealersController < ApplicationController
  def index
    dealers = Dealer.near( [params[:lat].to_f, params[:lon].to_f], 100)
    render json: dealers
  end

  def show
    @dealer = Dealer.find(params[:id])
    @drink_offers = @dealer.drink_offers.newest_groups
    set_breadcrumbs!
    render layout: !request.xhr?
  end

  def new
    @dealer = Dealer.new
  end

  def create
    @dealer = Dealer.new(dealer_params)
    if @dealer.save
      redirect_to @dealer, notice: 'Danke für die Eingabe. Bitte gib nun das Getränkeangebot an'
    else
      render :new
    end
  end

  private

  def dealer_params
    params.require(:dealer).permit(:name, :www, :country, :address, :zip, :phone, :city, :note)
  end

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
