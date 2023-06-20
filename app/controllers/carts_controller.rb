class CartsController < ApplicationController
  def show
  end

  # カートに商品を追加する
  def add_item
    @product = Product.find(params[:id])
    current_cart.add_item(@product.id)
    
    # Rails.logger.debug("controller:カートアイテム情報: #{current_cart.items.inspect}")
    redirect_to products_path, notice: 'カートに商品を追加しました'
  end
end
