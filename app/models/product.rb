# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image

  validates :name, presence: { message: "名前を入力してください" }
  validates :description, presence: { message: "説明を入力してください" }
  validates :price, presence: { message: "価格を入力してください" }
  validates :image, presence: { message: "画像を選択してください" }

end
