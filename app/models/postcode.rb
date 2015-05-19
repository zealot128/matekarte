class Postcode < ActiveRecord::Base
  belongs_to :federal_state
  has_many :dealers

  validates :name, presence: true
  validates :postcode, presence: true

  acts_as_url :name
  def to_param; url; end
end
