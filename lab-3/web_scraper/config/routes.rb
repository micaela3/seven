Rails.application.routes.draw do
  devise_for :users
  resources :courses do
    match '/scrape', to: 'courses#scrape', via: :post, on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'courses#index'
end
