class Order < ApplicationRecord
  belongs_to :cart

  # OrderとAddress、Paymentが1対1の関係になるように指定
  has_one :address
  has_one :payment

  # order.order_itemsとすると、そのorderに紐づくorder_itemsを取得できる
  accepts_nested_attributes_for :address, :payment
end
