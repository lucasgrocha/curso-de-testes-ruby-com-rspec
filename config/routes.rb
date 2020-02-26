Rails.application.routes.draw do
  resources :users, only: [ :index, :create ]
  resources :enemies, only: [ :index, :create, :show, :update, :destroy ]
  resources :weapons, only: [ :index, :create, :destroy, :show ]
end
