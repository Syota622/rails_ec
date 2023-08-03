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
    @total_price = calculate_total_price
  end

  # プロモーションコードを適用する
  def update
    @cart_items = @cart.cart_items
    apply_promo_code
    @promo_code = session[:promo_code]
    apply_promotion_if_available
    render :show
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

  # カートを取得する
  def set_cart
    @cart = session[:cart_id] ? Cart.find(session[:cart_id]) : Cart.create
    session[:cart_id] ||= @cart.id
  end

  # カートに入っている商品の合計金額を計算する
  def calculate_total_price
    @cart_items.reduce(0) do |sum, item|
      sum + item.product.price * item.quantity
    end
  end

  # プロモーションコードを適用する
  def apply_promo_code
    promo_code = params[:cart][:promo_code]
    return unless PromotionCode.exists?(code: promo_code)

    # セッションにプロモーションコードを保存
    session[:promo_code] = promo_code
  end

  def apply_promotion_if_available
    return unless @promo_code

    promotion = PromotionCode.find_by(code: @promo_code)
    if promotion
      @discount_amount = promotion.discount_amount
      @total_price = calculate_total_price - @discount_amount
      flash.now[:notice] = 'プロモーションコードを適用しました'
    else
      @discount_amount = nil
      flash.now[:alert] = 'プロモーションコードが無効です'
    end
  end
end
