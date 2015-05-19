class Postcode < ActiveRecord::Base
  belongs_to :federal_state
  has_many :dealers

  acts_as_url :name
  def to_param; url; end
end
