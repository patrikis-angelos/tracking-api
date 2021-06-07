Rails.application.routes.draw do
  resources :users, only: [:create, :update, :destroy] do
    resources :measurements, only: [:index, :create, :update, :destroy]
  end
  resources :units, only: [:index]
end
