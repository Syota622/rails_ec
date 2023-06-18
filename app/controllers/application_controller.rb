# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # 全てのコントローラーやビューからcurrent_cartメソッドを呼び出せるようにする
  helper_method :current_cart

  # Cartクラスは、rails_ec/app/models/cart.rbに定義されている
  def current_cart
    # nilの場合、Cart.new(session)を返す
    @current_cart ||= Cart.new(session)
  end
end
