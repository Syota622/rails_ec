# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_cart, only: %i[create]

  def create
    # Orderテーブルに購入者の情報を保存
    @order = Order.new(order_params)
    @order.cart = @cart

    if @order.save
      # OrderItemテーブルに購入した商品の情報を保存
      create_order_items

      # OrderMailerを使って購入者にメールを送信
      send_order_confirmation

      # カートを空にする
      clear_cart

      redirect_to products_path, notice: '購入ありがとうございます'
    else
      render :new
    end
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  end

  def order_params
    params.require(:order).permit(
      address_attributes: %i[first_name last_name user_name email_name address1 address2 prefectures post_code],
      payment_attributes: %i[card_name credit_number expiration cvv]
    )
  end

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

  def send_order_confirmation
    OrderMailer.order_confirmation(@order).deliver_later
  end

  def clear_cart
    session[:cart_id] = nil
  end
end
