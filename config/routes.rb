# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('/products')

  resources :products

  resource :cart

  resources :orders, only: [:new, :create]

  # add_item/:idのURLにアクセスがあった場合、cartsコントローラー(CartsController)のcreateアクションを呼び出す
  # asを省略した場合、add_item_path、remove_item_pathという名前のヘルパーメソッドが生成される
  # add_itemやremove_itemは、どのような名前でも構わないが、わかりやすい名前にするために、add_itemとremove_itemという名前にしている
  post 'add_item/:id', to: 'carts#create', as: 'create'
  delete 'remove_item/:id', to: 'carts#destroy', as: 'delete'

  namespace :admin do
    resources :products
  end
end
