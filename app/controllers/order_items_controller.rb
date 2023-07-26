# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :basic_auth

  # 購入明細一覧画面
  def index
    @orders = Order.all
  end

  # 購入明細詳細画面
  def show
    @order = Order.find(params[:id])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'pw'
    end
  end
end
