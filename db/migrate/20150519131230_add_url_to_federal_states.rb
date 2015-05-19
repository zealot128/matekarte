class AddUrlToFederalStates < ActiveRecord::Migration
  def change
    add_column :federal_states, :url, :string
    add_index :federal_states, :url

    add_column :postcodes, :url, :string
    add_index :postcodes, :url

    remove_column :dealers, :google_places_response
  end
end
