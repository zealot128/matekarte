class ListsController < ApplicationController
  def country
    @federal_states = FederalState.joins(:postcodes => :dealers).group("federal_states.id").select("federal_states.*, count(*) as count").order(:name)
  end

  def federal_state
    @federal_state = FederalState.find_by_url!(params[:federal_state])
  end

  def postcode
    @federal_state = FederalState.find_by_url!(params[:federal_state])
    @postcode = @federal_state.postcodes.find_by_url!(params[:postcode])
  end
end
