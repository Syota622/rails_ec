# frozen_string_literal: true

class CartsController < ApplicationController
  # カートの内容を表示する
  def index
    @current_cart = current_cart
  end

  def show
    @cart_items = current_cart.items
    @total_price = @current_cart.items.sum { |item| item[:product].price * item[:quantity] }
  end

  # カートに商品を追加する
  def create
    @product = Product.find(params[:id])
    quantity = params[:quantity].present? ? params[:quantity].to_i : 1
    quantity.times { current_cart.add_item(@product.id) }
    redirect_to products_path, notice: 'カートに商品を追加しました'
  end

  # カートから商品を削除する
  def destroy
    product = Product.find(params[:id])
    current_cart.remove_item(product.id)
    redirect_to cart_path, notice: 'カートから商品を削除しました'
  end

  private

  # Cartクラス
  def current_cart
    @current_cart ||= Cart.new(session)
  end
end
