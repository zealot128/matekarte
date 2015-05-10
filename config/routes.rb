Rails.application.routes.draw do
  resources :dealers do
    resource :drink_offers
  end
  root to: 'home#index'
end
