class Dealer < ActiveRecord::Base
  has_many :drink_offers
  has_many :drinks, through: :drink_offers

  geocoded_by :full_address, latitude: :lat, longitude: :lon

  before_create do
    if lat.blank?
      geocode
    end
  end

  def update_cached_json!
    json = drink_offers.newest_groups.pluck(:drink_id, :status).to_h
    update_column :cached_drinks, json
  end

  def full_address
    address + ", #{zip} #{city}"
  end

  def gmaps_link
    "https://www.google.de/maps/@#{lat},#{lon}"
  end

  def as_json(opts={})
    a = super
    a.except('bearing','created_at','updated_at','old_id')
  end
end
