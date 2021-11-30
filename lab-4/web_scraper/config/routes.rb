Rails.application.routes.draw do
  get "instructor_recommendation/index"
  get "instructor_recommendation/new", to: "instructor_recommendation#new"
  post "instructor_recommendation/new", to: "instructor_recommendation#create"
  get "student_application/index"
  get "student_application/new", to: "student_application#new"
  post "student_application/new", to: "student_application#create"
  get 'admin/index'
  get 'instructor/index'
  get 'student/index'
  get 'courses/index'
  devise_for :users

  # Route the clear table button in list of recommendations to the appropriate method
  post 'clear_table_instructor_recommendation', to: 'instructor_recommendation#clear_table'

  # Route the clear table button in list of recommendations to the appropriate method
  post 'clear_table_student_application', to: 'student_application#clear_table'

  # Actions for buttons on courses page
  resources :courses do
    # Route 'Scrape' button on page to main scrape functionality
    match '/scrape', to: 'courses#scrape', via: :post, on: :collection

    # Route 'Clear Table' button on page to method that clears & refreshes
    match '/clear_table', to: 'courses#clear_table', via: :post, on: :collection
  end
  root to: 'pages#home'
end
