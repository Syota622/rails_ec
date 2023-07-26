# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image

  validates :name, presence: { message: '名前を入力してください' }
  validates :description, presence: { message: '説明を入力してください' }
  validates :price, presence: { message: '価格を入力してください' }
  validates :image, presence: { message: '画像を選択してください' }

  # Product.cart_itemsとすると、そのcartに属するすべてのcart_itemsを取得Q
  # dependent: :destroyオプションは、Productが削除されたときに、それに紐づくCartItemも自動的に削除される
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
end
