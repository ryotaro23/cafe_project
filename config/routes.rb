Rails.application.routes.draw do

  get 'users/show'
  resources :events, only: [:show, :index] do
    # topページへのルーティングを追加
    collection do
      get 'top'
      get "greeting"
    end

    # resourceと短径になっていることに注意
    resource :event_joins, only: [:create, :destroy]
  end
  # get 'event/top', to: 'event#top'

  devise_for :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root  'events#index'  #この1行を追加

  resources :users, only: [:show, :edit, :update]

  get 'hello/index', to: 'hello#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'hello/create', to: 'hello#create'

end
