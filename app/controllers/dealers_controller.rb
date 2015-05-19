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
end
