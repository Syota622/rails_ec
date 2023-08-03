# frozen_string_literal: true

class Cart < ApplicationRecord
  # このカートに紐づくプロモーションコードを取得する
  attr_accessor :promo_code

  # cart.cart_itemsとすると、そのcartに属するすべてのcart_itemsを取得
  # dependent: :destroyオプションは、Cartが削除されたときに、それに紐づくCartItemも自動的に削除される
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_quantity
    cart_items.sum(:quantity)
  end
end
