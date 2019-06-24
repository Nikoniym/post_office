Rails.application.routes.draw do
  resources :parcel_lists

  root 'parcel_lists#index'
end
