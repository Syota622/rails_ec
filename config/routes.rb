Rails.application.routes.draw do
  # 削除ボタンをクリックしたときのルーティング
  delete 'admin/products/:id' => 'admin/products#destroy'

  resources :products

  namespace :admin do
    resources :products
  end
end
