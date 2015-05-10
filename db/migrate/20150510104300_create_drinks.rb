class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :www
      t.string :old_id
      t.string :review
      t.text :description

      t.timestamps null: false
    end
  end
end
