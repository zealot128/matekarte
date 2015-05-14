class Dealer < ActiveRecord::Base
  has_many :drink_offers
  has_many :drinks, through: :drink_offers

  geocoded_by :full_address,
    :latitude  => :lat, :longitude => :lon

  def full_address
    address + ", #{zip} #{city}"
  end

  def as_json(opts={})
    a = super
    dids =
      if respond_to?(:instant_drink_ids)
        instant_drink_ids
      else
        drink_ids
      end
    a.except('bearing','created_at','updated_at','old_id').merge(
      drink_ids: dids
    )
  end
end
