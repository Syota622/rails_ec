class OrdersController < ApplicationController
  before_action :set_cart, only: [:new, :create]

  def create
    @order = Order.new(order_params)
    @order.cart = @cart
  
    Rails.logger.debug("Params: #{params}") 
    Rails.logger.debug("Order_params: #{order_params}") 
  
    if @order.save
      @cart.cart_items.each do |item|
        OrderItem.create(
          order: @order,
          product: item.product,
          quantity: item.quantity,
          price: item.product.price
        )
      end
  
      session[:cart_id] = nil # カートを空にする
      flash[:notice] = '購入ありがとうございます'
      redirect_to products_path # 商品一覧ページにリダイレクト
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
      address_attributes: [:first_name, :last_name, :user_name, :email_name, :address1, :address2, :prefectures, :post_code],
      payment_attributes: [:card_name, :credit_number, :expiration, :cvv])
  end
end
