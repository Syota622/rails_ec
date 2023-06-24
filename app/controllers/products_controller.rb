# frozen_string_literal: true

class ProductsController < ApplicationController
  # GET /tasks or /tasks.json
  def index
    @products = Product.all
    @current_cart = current_cart
    @total_quantity = @current_cart.items.sum { |item| item[:quantity] }
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    set_task
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @product = Product.find(params[:id])
    @products = Product.order(created_at: :desc).limit(4)
  end

  def current_cart
    @current_cart ||= Cart.new(session)
  end
end
