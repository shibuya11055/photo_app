Rails.application.routes.draw do
  root to: 'photos#index'

  # ログイン
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # 外部連携
  get 'oauth/my_tweet_app', to: 'sessions#my_tweet_app_oauth', as: :my_tweet_app_oauth
  get 'oauth/callback', to: 'sessions#callback', as: :oauth_callback

  resources :photos, only: %i(index new create) do
    member do
      post :my_tweet_app_post
    end
  end
end
