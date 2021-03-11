Rails.application.routes.draw do
  resources :events do
    collection do
      get 'top'
    end
  end

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root  'events#index'  #この1行を追加
  get 'event/top', to: 'event#top'


  get 'hello/index', to: 'hello#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'hello/create', to: 'hello#create'
end
