class AddPostcodeToDealer < ActiveRecord::Migration
  def change
    add_reference :dealers, :postcode, index: true, foreign_key: true
  end
end
