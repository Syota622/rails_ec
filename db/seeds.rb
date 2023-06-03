# frozen_string_literal: true

# seeds.rb

# 商品データを作成
8.times do |i|
  product = Product.create(name: "商品名#{i}", description: "商品の説明#{i}")
  product.image.attach(
    io: File.open(
      Rails.root.join('app', 'assets', 'images', 'seeds', "image#{i}.png")
    ),
    filename: "image#{i}.png", content_type: 'image/png'
  )
end
