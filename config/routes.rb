# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/products')

  resources :products

  resource :cart

  post 'add_item/:id', to: 'carts#add_item', as: 'add_item'
  delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'

  namespace :admin do
    resources :products
  end
end
