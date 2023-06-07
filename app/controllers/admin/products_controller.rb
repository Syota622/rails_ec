class Admin::ProductsController < ApplicationController
  # 商品一覧の処理
  def index
    @products = Product.all
  end

  def show
    set_task
  end

  # 商品作成の処理
  def new
    
  end

  # 商品編集の処理
  def edit
    
  end

  # 商品削除の処理
  def destroy
    
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @product = Product.find(params[:id])
    @products = Product.order(created_at: :desc).limit(4)
  end
end
