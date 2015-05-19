class FederalState < ActiveRecord::Base
  has_many :postcodes

  def best_locations(top: 5)
    postcodes.joins(:dealers).select('postcodes.*, count(*) as count').group('postcodes.id').order('count desc').limit(top)
  end
end
