class CartsController < ApplicationController
  def show
  end

  # カートに商品を追加する
  def add_item
    @product = Product.find(params[:id])
    quantity = params[:quantity].present? ? params[:quantity].to_i : 1

    # timesメソッドで、指定した回数だけ繰り返し処理を行うことで、カートに商品を追加する
    quantity.times { current_cart.add_item(@product.id) }
    redirect_to products_path, notice: 'カートに商品を追加しました'
  end

  # カートから商品を削除する
  def remove_item
    product = Product.find(params[:id])
    current_cart.remove_item(product.id)
    redirect_to cart_path, notice: 'カートから商品を削除しました'
  end
end
