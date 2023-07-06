# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items
    @total_price = @cart_items.reduce(0) do |sum, item|
      sum + (item.product.price * item.quantity)
    end
  end

  def create
    product_id = params[:id].to_i
    quantity = params[:quantity].to_i
    item = @cart.cart_items.find_by(product_id: product_id)
    Rails.logger.debug("item.inspect: #{item.inspect}")
    if item
      item.quantity += quantity
      item.save
    else
      @cart.cart_items.create(product_id: product_id, quantity: quantity)
    end
    redirect_to products_path, notice: 'カートに商品を追加しました'
  end

  def destroy
    product_id = params[:id].to_i
    item = @cart.cart_items.find_by(product_id: product_id)

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
    Rails.logger.debug("@cart.inspect: #{@cart.inspect}")
    Rails.logger.debug("@cart.id: #{@cart.id}")
    session[:cart_id] ||= @cart.id
    Rails.logger.debug("session[:cart_id]: #{session[:cart_id]}")
  end
end
