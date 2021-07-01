Rails.application.routes.draw do
  resources :users
  resources :session, :only => [:create, :destroy]
end
