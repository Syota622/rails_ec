product = Product.new(name: "商品名", description: "商品の説明")
product.image.attach(
  io: File.open(
    Rails.root.join(
      'app', 'assets', 'images', 'seeds', "image1.png"
    )
  ), 
  filename: "image1.png", 
  content_type: 'image/png'
)
product.save!
