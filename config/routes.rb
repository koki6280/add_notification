Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :diaries do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :notifications, only: :index
  
  resources :events

  get 'users/:id/favorites' => 'users#favorites', as: 'user_favorites'
  get 'users/:id/graphs' => 'users#graphs', as: 'user_graphs'
  get 'search' => 'search#search'
  get 'my_calendar', to: 'events#my_calendar'
  root 'homes#top'
  get 'home/about' => 'homes#about'
end
