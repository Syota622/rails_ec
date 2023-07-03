# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :current_cart

  def index
    @products = Product.all
  end

  def show
    set_task
  end

  private

  # Cartクラス
  def current_cart
    @current_cart ||= Cart.new(session)
    @total_quantity = @current_cart.total_quantity
  end

  # 詳細画面
  def set_task
    @product = Product.find(params[:id])
    @products = Product.order(created_at: :desc).limit(4)
  end

end
