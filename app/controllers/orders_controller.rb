# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_cart, only: %i[create]

  def create
    # Orderテーブルに購入者の情報を保存
    @order = Order.new(order_params)
    # @order.cartへ@cartを代入することで、@orderに紐づくcart_idフィールドに@cartのidが保存されます。
    @order.cart = @cart

    # @orderがデータベースに保存され、その際にcart_idフィールドに@cartのidが保存されます。
    if @order.save
      # OrderItemテーブルに購入した商品の情報を保存
      create_order_items

      # OrderMailerを使って購入者にメールを送信
      send_order_confirmation

      # カートを空にする
      clear_cart

      # プロモーションコードが使用済みに更新
      update_promotion_code

      # 購入完了画面にリダイレクト
      redirect_to products_path, notice: '購入ありがとうございます'
    else
      render :new
    end
  end

  private

  # カートを取得する
  def set_cart
    @cart = Cart.find(session[:cart_id])
  end

  # 購入者の情報を取得する
  def order_params
    params.require(:order).permit(
      address_attributes: %i[first_name last_name user_name email_name address1 address2 prefectures post_code],
      payment_attributes: %i[card_name credit_number expiration cvv]
    )
  end

  # 購入した商品の情報を保存する
  def create_order_items
    @cart.cart_items.each do |item|
      OrderItem.create(
        order: @order,
        product: item.product,
        quantity: item.quantity,
        name: item.product.name,
        price: item.product.price
      )
    end
  end

  # 購入者にメールを送信する
  def send_order_confirmation
    # セッションからプロモーションコードを取得
    promo_code = session[:promo_code]
    # プロモーションコードが存在する場合は、そのプロモーションコードに紐づく割引額を@orderに代入
    promotion = PromotionCode.find_by(code: promo_code)
    if promotion
      @order.promo_code = promo_code
      @order.discount_amount = promotion.discount_amount
    end
    OrderMailer.order_confirmation(@order).deliver_later
  end

  # プロモーションコードが使用済みに更新する
  def update_promotion_code
    # セッションからプロモーションコードを取得
    promo_code = session[:promo_code]
    promotion = PromotionCode.find_by(code: promo_code, used: false)
    return unless promotion

    promotion.update(used: true)
  end

  # カートを空にする
  def clear_cart
    session[:cart_id] = nil
  end
end
