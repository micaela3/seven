Rails.application.routes.draw do
  devise_for :users
  resources :courses do
    # Route 'Scrape' button on page to main scrape functionality
    match '/scrape', to: 'courses#scrape', via: :post, on: :collection

    # Route 'Clear Table' button on page to method that clears & refreshes
    match '/clear_table', to: 'courses#clear_table', via: :post, on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'courses#index'
end
