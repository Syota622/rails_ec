# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # 全てのコントローラーやビューからcurrent_cartメソッドを呼び出せるようにする
  helper_method :current_cart

  # Cartクラスは、rails_ec/app/models/cart.rbに定義されている
  def current_cart
    # nilの場合、Cart.new(session)を返す→Railsのメモ化
    # add_itemメソッドを呼び出す
    @current_cart ||= Cart.new(session)
    Rails.logger.debug("ApplicationController#current_cart: current_cart.items: #{@current_cart.items.inspect}")

    # 戻り値
    @current_cart
  end
end
