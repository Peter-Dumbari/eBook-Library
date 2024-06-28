Rails.application.routes.draw do
   # Devise routes for user authentication
   devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

    resources :categories
    resources :books do
      collection do
        get 'fetch_by_title'
        get 'fetch_by_category'
      end
    end
    resources :reservations
    resources :borrows
    end
  end
end
