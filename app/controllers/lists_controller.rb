class ListsController < ApplicationController
  def country
    @federal_states = FederalState.joins(:postcodes => :dealers).group("federal_states.id").select("federal_states.*, count(*) as count").order(:name)
    @breadcrumbs = [
      [ '/', 'Mate'],
      [ '/mate/in', 'Deutschland'],
    ]
  end

  def federal_state
    @federal_state = FederalState.find_by_url!(params[:federal_state])
    @breadcrumbs = [
      [ '/', 'Mate'],
      [ '/mate/in', 'Deutschland'],
      [ view_context.location_url(federal_state: @federal_state), @federal_state.name]
    ]
  end

  def postcode
    @federal_state = FederalState.find_by_url!(params[:federal_state])
    @postcode = @federal_state.postcodes.find_by_url!(params[:postcode])
    @breadcrumbs = [
      [ '/', 'Mate'],
      [ '/mate/in', 'Deutschland'],
      [ view_context.location_url(federal_state: @federal_state), @federal_state.name],
      [ view_context.location_url(federal_state: @federal_state, postcode: @postcode), @postcode.name]
    ]
  end
end
