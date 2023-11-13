# frozen_string_literal: true

Rails.application.routes.draw do
  root 'invoices#new'

  resources :invoices, only: [:create]
end
