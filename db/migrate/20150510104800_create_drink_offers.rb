class CreateDrinkOffers < ActiveRecord::Migration
  def change
    create_table :drink_offers do |t|
      t.belongs_to :dealer, index: true, foreign_key: true
      t.belongs_to :drink, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
