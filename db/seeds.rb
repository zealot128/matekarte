data = Oj.load(File.read('db/matekarte.json'))


drink_hash = {}
data['drinks'].each do |drink_raw|
  drink_data = JSON.load(drink_raw)
  drink = Drink.where(old_id: drink_data['id']).first_or_create!(description: drink_data['description'], name: drink_data['name'],
                                                                 www: drink_data['www'], review: drink_data['review'])
  drink_hash[drink_data['id']] = drink.id
end

DrinkOffer.delete_all
Dealer.delete_all

ActiveRecord::Base.logger = Logger.new('/dev/null')
i = 0
puts "#{data['dealers'].count} dealer"
data['dealers'].each do |dealer_data|
  if (i+=1) % 1000 == 0
    puts i
  end
  attrs = dealer_data.slice( "address", "www", "zip", "country",  "name", "phone", "city", "note")
  attrs['lat'], attrs['lon'] = dealer_data['coordinates']
  dealer = Dealer.where(old_id: dealer_data['id']).first_or_initialize(attrs)
  dealer.save(validate:false)
  (dealer_data['statuses'] || []).each do |status|
    old_drink_id = status['drink_id']
    drink_id = drink_hash[old_drink_id] || (raise "FOOBAR: #{old_drink_id}")
    dealer.drink_offers.create!(drink_id: drink_id, status: status['status'] || 0, created_at: status['created_at'])
  end
  (dealer_data['drink_id'] || []).each do |did|
    drink_id = drink_hash[did]
    if !dealer.drink_ids.include?(drink_id)
      dealer.drink_offers.create!(drink_id: drink_id, status: 0, created_at: dealer.created_at)
    end
  end
end

load 'db/seeds/geodb.rb'

read_data
import
assign_dealer
