Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  get '/users/search', to: 'users#search'
  resources :messages
  resources :groups, only: %i(index new create edit update) do
    resources :messages, only: %i(index create)
  end
end
