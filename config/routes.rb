Rails.application.routes.draw do
  resources :dealers do
    resource :drink_offers
  end
  resources :drinks
  get 'impressum' => 'home#impressum'

  get 'mate/in' => 'lists#country'
  get 'mate/in/:federal_state' => 'lists#federal_state'
  get 'mate/in/:federal_state/:postcode' => 'lists#postcode'

  root to: 'home#index'
end
