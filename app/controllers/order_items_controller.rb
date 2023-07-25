# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :basic_auth

  def index
    @orders = Order.all
  end

  def show
    @order_items = OrderItem.where(order_id: params[:id])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'pw'
    end
  end
end
