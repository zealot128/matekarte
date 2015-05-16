class AddCachedDrinksToDealers < ActiveRecord::Migration
  def change
    add_column :dealers, :cached_drinks, :json
  end
end
