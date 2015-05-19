class Dealer < ActiveRecord::Base
  has_many :drink_offers
  has_many :drinks, through: :drink_offers
  belongs_to :federal_state
  belongs_to :postcode

  geocoded_by :full_address, latitude: :lat, longitude: :lon
  validates :address, presence: true
  validates :zip, presence: true
  validates :city, presence: true
  validates :name, presence: true
  validates :www, format: { with: %r{\Ahttps?:\/\/|\A\z} }

  before_create do
    if lat.blank?
      geocode
    end
  end

  def update_cached_json!
    json = drink_offers.newest_groups.map{|i| [i.drink_id, i.status]}.to_h
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
