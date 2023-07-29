# frozen_string_literal: true

class Order < ApplicationRecord
  # Orderオブジェクトがデータベースに保存される直前（すなわち、.saveまたは.updateメソッドが呼び出されたとき）に行われる処理を指定
  before_save :apply_promotion_code

  belongs_to :cart

  has_many :order_items, dependent: :destroy

  # OrderとAddress、Paymentが1対1の関係になるように指定
  has_one :address, dependent: :destroy
  has_one :payment, dependent: :destroy

  # order.order_itemsとすると、そのorderに紐づくorder_itemsを取得できる
  accepts_nested_attributes_for :address, :payment

  private
  
  def apply_promotion_code
    if promotion_code.present? && !promotion_code.used
      # ここで割引を適用するロジックを書く
      promotion_code.update(used: true)
    end
  end
end
