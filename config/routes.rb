Rails.application.routes.draw do
  # devise_for :users, only: [:sessions]

  namespace :api, :defaults => { :format => 'json' } do
    # resources :musicians, only: [:index, :show]
    resources :calories, only: [:index, :create, :update, :destroy]
    resources :foods, only: [:index]
    get "/exceeded_calories", to: 'calories#exceeded_calories', as: :exceeded_calories
    resources :session, only: [:create]
    resources :users, only: [:update]

    namespace :admin do
      resources :calories, only: [:index, :create, :update, :destroy]
      get "/exceeded_calories", to: 'calories#exceeded_calories', as: :admin_exceeded_calories
      resources :foods, only: [:index]
      resources :users, only: [:index]
      resources :session, only: [:create]
      resources :dashboard, only: :index
      resources :musicians, except: :show
    end
  end

  get '/admin', to: 'admin#index'
  match "/admin/*path", to: "admin#index", format: false, via: :get

  root :to => "application#index"
  match "*path", to: "application#index", format: false, via: :get
end
