Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root 'users/home#top'

  scope module: :users do
  	get 'users/destroy_page'
  	resources :users, only: [:index, :show, :edit, :update], shallow: true do
      resources :relationships, only: [:create, :destroy]
    end
  	resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy], shallow: true do
  		resources :comments, only: [:create, :destroy]
  		resources :likes, only: [:create, :destroy]
  	end

    get 'search' => 'posts#search'
  end

  namespace :admins do
  	resources :users, only: [:index, :destroy]
  	resources :posts, only: [:index, :show, :destroy]
  end
end
