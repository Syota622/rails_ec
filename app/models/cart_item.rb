# frozen_string_literal: true

class CartItem < ApplicationRecord
  # cart_item.cartとすると、そのcart_itemが属しているcartを取得できる
  belongs_to :cart
  belongs_to :product
end
