Rails.application.routes.draw do
  resources :user do
    resources :measurement
  end
  resources :unit
end
