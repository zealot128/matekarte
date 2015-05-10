class Dealer < ActiveRecord::Base
  has_many :drink_offers
  has_many :drinks, through: :drink_offers

  geocoded_by :full_address,
    :latitude  => :lat, :longitude => :lon

  def full_address
    address + ", #{zip} #{city}"
  end
end
