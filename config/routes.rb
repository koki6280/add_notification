Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :diaries do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :events
  get 'search' => 'search#search'
  get 'my_calendar', to: 'events#my_calendar'
  root 'homes#top'
  get 'home/about' => 'homes#about'
end
