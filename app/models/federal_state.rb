class FederalState < ActiveRecord::Base
  has_many :postcodes

  acts_as_url :name

  def best_locations(top: 5)
    postcodes.joins(:dealers).select('postcodes.*, count(*) as count').group('postcodes.id').order('count desc, name').limit(top)
  end

  def to_param; url; end

  def dealer_count
    postcodes.joins(:dealers).count
  end
end
