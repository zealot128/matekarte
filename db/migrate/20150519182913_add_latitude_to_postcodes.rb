class AddLatitudeToPostcodes < ActiveRecord::Migration
  def change
    change_table :postcodes do |t|
      t.float :latitude
      t.float :longitude
    end
  end
end
