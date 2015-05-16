Dealer.where('google_places_response is null').limit(1000).find_each do |d|
  d.update_google_place!
end
