Rails.application.routes.draw do
  root 'invoices#new'

  namespace :api do
    resources :invoices, only: [:create]
  end
end
