Rails.application.routes.draw do
  devise_for :users, controller: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json } do
    resources :categories
    resources :books
    resources :reservations
    resources :borrows
  end
end
