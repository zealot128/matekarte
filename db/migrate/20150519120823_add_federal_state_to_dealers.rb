class AddFederalStateToDealers < ActiveRecord::Migration
  def change
    add_reference :dealers, :federal_state, index: true, foreign_key: true
  end
end
