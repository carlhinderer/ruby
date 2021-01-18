Rails.application.routes.draw do
  resources :reports, only: [:index, :show, :new, :create, :destroy]
  root 'reports#index'
  post '/reports/preview', to: 'reports#preview'
end