class AddSomeIndices < ActiveRecord::Migration
  def change
    add_index :federal_states, [:country, :name]
    add_index :postcodes, [:federal_state_id, :postcode, :name]
    add_index :postcodes, [:postcode, :name]
    add_index :postcodes, :postcode
  end
end
