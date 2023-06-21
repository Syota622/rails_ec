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
end
