Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: 'home#top'

  namespace :user do
    get "home/top" => "home#top"
  end

  scope module: :user do
    resources :categories, only: [:index]
  end

end
