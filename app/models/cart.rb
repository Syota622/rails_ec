class Cart
  def initialize(session)
    # 他のメソッドからもsessionを使えるようにする
    @session = session
    @session[:cart] ||= {}
    # Rails.logger.debug("Cart initialized. Session contents: #{@session.inspect}")
  end
  
  def add_item(product_id)
    @session[:cart][product_id] = (@session[:cart][product_id] || 0) + 1
    # Rails.logger.debug("Item added. Session contents: #{@session.inspect}")
  end

  # 商品(product_id)ごとに追加した個数(quantity)を取得する
  def items
    @session[:cart].map do |product_id, quantity|
      { product: Product.find(product_id.to_i), quantity: quantity }
    end
  end

end
