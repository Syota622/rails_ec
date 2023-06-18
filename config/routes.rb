# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products

  resource :cart

  # add_item/:idのURLにアクセスがあった場合、cartsコントローラー(CartsController)のadd_itemアクションを呼び出す
  # 名前付きadd_item_pathヘルパーを生成
  post 'add_item/:id', to: 'carts#add_item', as: 'add_item'

  namespace :admin do
    resources :products
  end
end
