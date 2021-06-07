Rails.application.routes.draw do
  resources :users, only: [:create]
  post "/login", to: "users#login"
  resources :units, only: [:index, :show] do
    resources :measurements, only: [:index, :create, :update, :destroy]
  end
end
