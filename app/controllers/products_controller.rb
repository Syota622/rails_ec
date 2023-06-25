# frozen_string_literal: true

class ProductsController < ApplicationController
  # GET /tasks or /tasks.json
  def index
    @products = Product.all
    current_cart
    total_quantity
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    set_task
    current_cart
    total_quantity
  end

  private

  # 詳細画面
  def set_task
    @product = Product.find(params[:id])
    @products = Product.order(created_at: :desc).limit(4)
  end

  # Cartクラス
  def current_cart
    @current_cart ||= Cart.new(session)
  end

  # 商品のカート数
  def total_quantity
    @total_quantity = @current_cart.items.sum { |item| item[:quantity] }
  end
end
