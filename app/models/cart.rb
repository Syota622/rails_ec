class Cart
  def initialize(session)
    @session = session
    @session[:cart] ||= {}
    # Rails.logger.debug("Cart initialized. Session contents: #{@session.inspect}")
  end
  
  def add_item(product_id)
    @session[:cart][product_id] = (@session[:cart][product_id] || 0) + 1
    # Rails.logger.debug("Item added. Session contents: #{@session.inspect}")
  end

  def items
    @session[:cart].map do |product_id, quantity|
      { product: Product.find(product_id.to_i), quantity: quantity }
    end
  end

end
