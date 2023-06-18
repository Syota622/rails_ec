class CartsController < ApplicationController
  def show
  end

  # カートに商品を追加する
  def add_item
    @product = Product.find(params[:id])
    # Cartクラス(application_controller.rb)のadd_itemメソッドを呼び出す
    current_cart.add_item(@product.id)
    redirect_to products_path, notice: 'Item added to cart'
  end

end
