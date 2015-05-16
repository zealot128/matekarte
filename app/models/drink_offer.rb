class DrinkOffer < ActiveRecord::Base
  belongs_to :dealer
  belongs_to :drink

  enum status: [:unknown, :available, :almost_empty, :empty]

  validates :status, presence: true
  validates :drink, presence: true
  validates :dealer, presence: true

  scope :newest_groups, ->{
    select('distinct on (drink_id) drink_offers.*').
    order('drink_id, created_at desc')
  }
  def bootstrap_class
    case status
    when 'empty','unknown', nil then 'danger'
    when 'available' then 'success'
    when 'almost_empty' 'warning'
    end
  end

  def status_name
    self.class.status_translate(status)
  end

  def self.status_translate(status)
    status ||= 'unknown'
    I18n.t("drink_offers.statuses.#{status}")
  end

  def as_json(opts={})
    super.except('created_at','updated_at').merge(bootstrap_class: bootstrap_class)
  end
end
