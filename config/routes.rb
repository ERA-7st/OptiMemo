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
    resources :categories, only: [:index, :create, :destroy]
    resources :words
    resources :reviews, only: [:index]
    get "category_words/modal_index" => "category_words#modal_index", as: "category_words_modal_index"
    get "category_words/set_category/:id" => "category_words#set_category", as: "set_category"
    get "category_words/remove_category/:id" => "category_words#remove_category", as: "remove_category"
    get "category_words/set_new_category" => "category_words#set_new_category", as: "set_new_category"
    get "category_words/remove_new_category/:name" => "category_words#remove_new_category", as: "remove_new_category"
  end

end
