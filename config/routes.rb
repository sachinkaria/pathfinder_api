Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', defaults: { format: :json }
  resources :users, only: [:show, :index]

  resources :posts

  resources :conversations do
    resources :messages
  end

  root 'posts#index'
end
