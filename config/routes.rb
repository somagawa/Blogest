Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root 'users/home#top'

  scope module: :users do
  	get 'users/destroy_page'
  	resources :users, only: [:index, :show, :edit, :update]
  	resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
  		resource :comments, only: [:create, :destroy]
  		resource :likes, only: [:create, :destroy]
  	end
  end

  namespace :admins do
  	resources :users, only: [:index, :destroy]
  	resources :posts, only: [:index, :show, :destroy]
  end
end
