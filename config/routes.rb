Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :users, only: [:show]
  resources :posts
  root 'posts#index'
end
