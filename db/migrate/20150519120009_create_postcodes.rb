class CreatePostcodes < ActiveRecord::Migration
  def change
    create_table :postcodes do |t|
      t.belongs_to :federal_state
      t.string :postcode
      t.string :name
    end
  end
end
