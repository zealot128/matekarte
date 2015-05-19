class ListsController < ApplicationController
  def country
    @federal_states = FederalState.joins(:postcodes => :dealers).group("federal_states.id").select("federal_states.*, count(*) as count").order(:name)
  end

  def federal_state
  end

  def city
  end
end
