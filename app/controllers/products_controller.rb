# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_cart

  def index
    @products = Product.all
    @total_quantity = @cart.total_quantity
  end

  def show
    set_task
    @total_quantity = @cart.total_quantity
  end

  private

  def set_cart
    @cart = session[:cart_id] ? Cart.find(session[:cart_id]) : Cart.create
    session[:cart_id] ||= @cart.id
  end

  # 詳細画面
  def set_task
    @product = Product.find(params[:id])
    @products = Product.order(created_at: :desc).limit(4)
  end
end
