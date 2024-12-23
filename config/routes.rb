Rails.application.routes.draw do
  root to: 'photos#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :photos, only: %i(index new create)

  get 'oauth/my_tweet_app', to: 'sessions#my_tweet_app_oauth', as: :my_tweet_app_oauth
  get 'oauth/callback', to: 'sessions#callback', as: :oauth_callback
end
