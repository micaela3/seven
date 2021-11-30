Rails.application.routes.draw do
  get "student_application/new"
  post "student_application/new", to: "student_application#create"
  devise_for :users
  get 'admin/index'
  get 'instructor/index'
  get 'student/index'
  get 'courses/index'
  

  # Links for buttons on homepage
  # resources :pages do
  #   collection do
  #     get :temp
  #   end
  # end

  # Actions for buttons on courses page
  resources :courses do
    # Route 'Scrape' button on page to main scrape functionality
    match '/scrape', to: 'courses#scrape', via: :post, on: :collection

    # Route 'Clear Table' button on page to method that clears & refreshes
    match '/clear_table', to: 'courses#clear_table', via: :post, on: :collection
  end
  # root to: 'courses#index'
  root to: 'pages#home'
end
