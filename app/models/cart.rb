class Cart
  def initialize(session)
    @session = session
    @session[:cart] ||= {}
  end
  
  def add_item(product_id)
    @session[:cart][product_id] = (@session[:cart][product_id] || 0) + 1
  end

  def items
    
    return [] if @session[:cart].empty?

    @session[:cart].map do |product_id, quantity|
      { product: Product.find(product_id.to_i), quantity: quantity }
    end
  end
end
