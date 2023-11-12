Rails.application.routes.draw do
  root 'invoices#new'

  resources :invoices, only: [:create]
end
