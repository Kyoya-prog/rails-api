Rails.application.routes.draw do
  resources :patiences do
    collection do
      get :per_month
      get :per_day
    end
  end
  resources :users, :only => [:create]
  resources :session, :only => [:create, :destroy]
  root 'application#hello'
end
