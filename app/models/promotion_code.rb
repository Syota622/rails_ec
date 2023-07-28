class PromotionCode < ApplicationRecord
  # プロモーションコード
  validates :code, presence: true, length: { is: 7 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
  # 割引額
  validates :discount_amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 100, less_than_or_equal_to: 1000 }
  # 使用済みかどうか
  validates :used, inclusion: { in: [true, false] }

  # has_many :orders
end
