class Postcode < ActiveRecord::Base
  belongs_to :federal_state
  has_many :dealers
end
