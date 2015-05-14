Rails.application.routes.draw do
  resources :dealers do
    resource :drink_offers
  end
  resources :drinks
  root to: 'home#index'
end
