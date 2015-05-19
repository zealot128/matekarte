class CreateFederalStates < ActiveRecord::Migration
  def change
    create_table :federal_states do |t|
      t.string :country
      t.string :name
      t.string :short
    end
  end
end
