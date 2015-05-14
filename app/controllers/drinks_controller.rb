class DrinksController < ApplicationController
  def index
    render json: Drink.all
  end
end
