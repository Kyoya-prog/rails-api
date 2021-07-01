Rails.application.routes.draw do
  resources :users
  resources :patiences
  resources :session, :only => [:create, :destroy]
end
