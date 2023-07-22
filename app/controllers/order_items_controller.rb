# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :basic_auth

  def index
    @order_items = OrderItem.all
  end

  def show
    @order_item = OrderItem.find(params[:id])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'pw'
    end
  end
end
