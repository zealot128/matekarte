class DrinkOffer < ActiveRecord::Base
  belongs_to :dealer
  belongs_to :drink

  def as_json(opts={})
    super.except('created_at','updated_at')
  end
end
