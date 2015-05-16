class DrinkOffer < ActiveRecord::Base
  belongs_to :dealer
  belongs_to :drink

  STATUS = ['unbekannt', 'vorhanden', '??', '??']
  scope :newest_groups, ->{
    select('distinct on (drink_id) drink_offers.*').
    order('drink_id, created_at desc')
  }

  def as_json(opts={})
    super.except('created_at','updated_at')
  end
end
