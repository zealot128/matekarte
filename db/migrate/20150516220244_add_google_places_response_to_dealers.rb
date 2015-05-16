class AddGooglePlacesResponseToDealers < ActiveRecord::Migration
  def change
    add_column :dealers, :google_places_response, :json
  end
end
