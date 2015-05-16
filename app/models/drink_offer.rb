class DrinkOffer < ActiveRecord::Base
  belongs_to :dealer
  belongs_to :drink

  STATUS = ['unbekannt', 'vorhanden', '??', '??']
  scope :newest_groups, ->{
    select('distinct on (drink_id) drink_offers.*').
    order('drink_id, created_at desc')
  }
  def bootstrap_class
    case status
    when 0, nil then 'danger'
    when 1 then 'success'
    when 2,3 then 'warning'
    end
  end

  def as_json(opts={})
    super.except('created_at','updated_at').merge(bootstrap_class: bootstrap_class)
  end
end
