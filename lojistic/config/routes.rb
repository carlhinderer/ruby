Rails.application.routes.draw do
  resources :reports
  root 'reports#index'
  post '/reports/preview', to: 'reports#preview'
end