def read_data
  file = File.read('db/seeds/DE.tab')
  lines = file.lines.map{|i| i.split("\t") }
  lines.each{|l| l.last.strip! }
  headline = lines.shift
  $rows = lines.map{|i| [i.first, headline.zip(i).to_h] }.to_h

  $staedte = $rows.reject{|id,i|
    i['plz'].blank? || ['Dorf', 'Ortsteil'].include?(i['typ'])
  }
end

def federal_state(stadt)
  if (stadt['typ'] == 'Bundesland')
    return stadt
  elsif (parent = $rows[stadt['of']])
    federal_state(parent)
  else
    nil
  end
end


def import
  read_data
  FederalState.delete_all
  Postcode.delete_all
  ActiveRecord::Base.logger = Logger.new('/dev/null')
  i = 0
  c = $staedte.count
  $staedte.each do |id, stadt|
    if (i+=1) % 1000 == 0
      puts " DS #{i} / #{c}"
    end
    state = federal_state(stadt)
    if state
      fstate = FederalState.where(country: 'Deutschland', name: state['name']).first_or_create!(short: state['kz'])
      Postcode.where(federal_state_id: fstate.id, postcode: stadt['plz'], name: stadt['name']).first_or_create!
    end
  end
  puts "#{FederalState.count} Bundeslaender importiert"
  puts "#{Postcode.count} Staedte importiert"
end

def assign_dealer
  puts "Dealer zuweisen..."
  Dealer.where('federal_state_id is null').find_each do |dealer|
    base = Postcode.where('postcode like ?', "%#{dealer.zip.strip}%")
    postcode = base.where(name: dealer.city.strip).first
    postcode ||= base.first
    if postcode
      dealer.federal_state = postcode.federal_state
      dealer.postcode = postcode
      dealer.save! validate: false
    end
  end
end
