require 'rails_helper'

describe 'Browsing', js: true do
  specify 'Startseite + Impressum' do
    visit '/'
    click_on 'Impressum'
    page.should have_content 'Impressum'
  end

  specify 'List' do
    sn = FederalState.create!(name: 'Sachsen')
    dd = Postcode.create!(name: 'Dresden', federal_state: sn, postcode: '01309')
    mate = Drink.create!(name: 'Club Mate')

    dealer = Dealer.create!(postcode: dd, federal_state: sn, zip: '01309', city: 'Dresden', name: 'Kaufland', www: '', address: 'Borsbergstraße 35', note: '', lat: 51.0768338,lon: 13.7725857)
    dealer.drink_offers.create!(status: :available, drink: mate)

    Dealer.find(dealer.id).tap do |d|
      d.drink_offers.count.should == 1
      d.federal_state.should == sn
      d.postcode.should == dd
      d.drink_offers.first.drink.should == mate
    end
    sleep 1

    visit '/'
    click_on 'Listen'
    click_on 'Sachsen'
    click_on 'Dresden'
    page.should have_content 'Kaufland'
    click_on 'Kaufland'
  end

  specify 'Dealer anlegen' do
    sn = FederalState.create!(name: 'Sachsen')
    dd = Postcode.create!(name: 'Dresden', federal_state: sn, postcode: '01309')
    mate = Drink.create!(name: 'Club Mate')

    visit '/impressum'
    click_on 'Händler eintragen'
    fill_in 'Name', with: 'Kaufland'
    fill_in 'Straße', with: 'Borsbergstraße 35'
    fill_in 'Postleitzahl', with: '01309'
    fill_in 'Stadt', with: 'Dresden'
    fill_in 'Hinweise', with: 'foobar'

    click_on 'Speichern'
    click_on 'Angebot nicht aktuell?'
    select 'Club Mate'
    choose 'Verfügbar'
    click_on 'Speichern'

    page.should have_content 'Information aktualisiert'
    page.should have_content 'Club Mate'

    Dealer.first.tap do |d|
      d.should be_present
      d.name.should == 'Kaufland'
      d.latitude.should be_present

      d.drink_offers.count.should == 2
      d.drink_offers.first.tap do |offer|
        offer.drink.should == mate
      end
      d.postcode.should == dd
      d.federal_state.should == sn
      d.cached_drinks.should be_present
    end
  end
end
