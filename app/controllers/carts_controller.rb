# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart

  def show
    # @orderは、form_withで使うために定義している
    @order = Order.new

    # @orderに紐づくaddressとpaymentを作成
    @order.build_address
    @order.build_payment

    # カートに入っている商品の一覧を取得
    @cart_items = @cart.cart_items

    # カートに入っている商品の合計金額を計算
    @total_price = @cart_items.reduce(0) do |sum, item|
      sum + (item.product.price * item.quantity)
    end
  end

  # カートに商品を追加する
  def create
    product_id = params[:id].to_i
    quantity = params[:quantity].to_i
    item = @cart.cart_items.find_by(product_id: product_id)
    if item
      item.quantity += quantity
      item.save
    else
      @cart.cart_items.create(product_id: product_id, quantity: quantity)
    end
    redirect_to products_path, notice: 'カートに商品を追加しました'
  end

  # カートから商品を削除する
  def destroy

    # カートから削除する商品のidを取得
    product_id = params[:id].to_i
    item = @cart.cart_items.find_by(product_id: product_id)

    # itemが存在する場合は削除し、存在しない場合はエラーを表示する
    if item
      item.destroy
      redirect_to cart_path(@cart), notice: 'カートから商品を削除しました'
    else
      redirect_to cart_path(@cart), alert: '指定された商品はカートに存在しません'
    end
  end

  private

  def set_cart
    @cart = session[:cart_id] ? Cart.find(session[:cart_id]) : Cart.create
    session[:cart_id] ||= @cart.id
  end
end
