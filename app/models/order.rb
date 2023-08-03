# frozen_string_literal: true

class Order < ApplicationRecord
  attr_accessor :promo_code

  belongs_to :cart

  has_many :order_items, dependent: :destroy

  # OrderとAddress、Paymentが1対1の関係になるように指定
  has_one :address, dependent: :destroy
  has_one :payment, dependent: :destroy

  # order.order_itemsとすると、そのorderに紐づくorder_itemsを取得できる
  accepts_nested_attributes_for :address, :payment
end
