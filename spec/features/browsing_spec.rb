require 'rails_helper'

describe 'Browsing', js: true do
  specify 'Startseite + Impressum' do
    visit '/'
    click_on 'Impressum'
    page.should have_content 'Impressum'
  end

  specify 'Listen' do
    sn = FederalState.create!(name: 'Sachsen')
    dd = Postcode.create!(name: 'Dresden', federal_state: sn, postcode: '01309')
    mate = Drink.create!(name: 'Club Mate')

    dealer = Dealer.create!(postcode: dd, federal_state: sn, zip: '01309', city: 'Dresden', name: 'Kaufland', www: '', address: 'Borsbergstraße 35', note: '', lat: 51.0768338,lon: 13.7725857)
    dealer.drink_offers.create!(status: :available, drink: mate)

    sleep 1
    visit '/'
    click_on 'Listen'
    click_on 'Sachsen'
    click_on 'Dresden'
    page.should have_content 'Kaufland'
    click_on 'Kaufland'
  end
end
