# frozen_string_literal: true

class Cart < ApplicationRecord
  def initialize(session)
    @session = session
    @session[:cart] ||= {}

    # idを数値に変換して、@itemsに代入する
    @items = @session[:cart].transform_keys(&:to_i)
  end

  # @items = {26=>5, 27=>1}
  def add_item(product_id)
    # product_idを数値に変換
    product_id = product_id.to_i

    # @items[product_id]に、個数を加算する（商品追加ボタンをクリックしたか数）
    @items[product_id] ||= 0
    @items[product_id] += 1
    update_session
  end

  # 商品(product_id)ごとに追加した個数(quantity)を取得する
  def items
    @session[:cart].map do |product_id, quantity|
      { product: Product.find(product_id.to_i), quantity: quantity }
    end
  end

  # カートから商品を削除する
  # Cart#remove_item: @items before deletion: {26=>9, 27=>9, 28=>3, 31=>4}
  # Cart#remove_item: @items after deletion: {27=>9, 28=>3, 31=>4}
  def remove_item(id)
    @items.delete(id.to_i)
    update_session
  end

  private

  # セッションが破棄されるのを防ぐために、状態を保持するためのメソッドを定義
  # @session[:cart] = {26=>5, 27=>1}
  def update_session
    @session[:cart] = @items
  end
end
