class DrinkOffer < ActiveRecord::Base
  belongs_to :dealer
  belongs_to :drink
end
