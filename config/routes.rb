# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/products')

  resources :products

  resource :cart

  # add_item/:idのURLにアクセスがあった場合、cartsコントローラー(CartsController)のcreateアクションを呼び出す
  post 'add_item/:id', to: 'carts#create', as: 'create'
  delete 'remove_item/:id', to: 'carts#destroy', as: 'delete'

  namespace :admin do
    resources :products
  end
end
