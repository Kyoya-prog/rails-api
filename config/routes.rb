Rails.application.routes.draw do
  get 'home/index'
  resources :patiences do
    collection do
      get :per_month
      get :per_day
    end
  end
  resources :users, :only => [:create]
  resources :session, :only => [:create, :destroy] do
    collection do
      get :check
    end
  end
  root to: 'home#index'
  get 'privacy' ,to: 'home#privacy'
end
