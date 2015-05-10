class CreateDealers < ActiveRecord::Migration
  def change
    create_table :dealers do |t|
      t.string :old_id
      t.string :name
      t.string :www
      t.float :lat
      t.float :lon
      t.string :country
      t.string :address
      t.string :zip
      t.string :phone
      t.string :city
      t.text :note

      t.timestamps null: false
    end
  end
end
