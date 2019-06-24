Rails.application.routes.draw do
  resources :parcel_lists, only: %i[index create]

  root 'parcel_lists#index'
end
