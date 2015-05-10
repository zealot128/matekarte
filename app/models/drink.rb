class Drink < ActiveRecord::Base
  has_many :drink_offers
  has_many :dealers, through: :drink_offers
end
