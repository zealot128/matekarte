class Postcode < ActiveRecord::Base
  belongs_to :federal_state
  has_many :dealers

  validates :name, presence: true
  validates :postcode, presence: true

  acts_as_url :name
  geocoded_by :full_address, latitude: :lat, longitude: :lon

  def full_address
    "#{postcode} #{name}, #{federal_state.name}, #{federal_state.country}"
  end

  def to_param; url; end
end
