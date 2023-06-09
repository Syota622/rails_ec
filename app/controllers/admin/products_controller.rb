class Admin::ProductsController < ApplicationController
  # 商品一覧
  def index
    @products = Product.all
  end

  def show
    set_task
  end

  # 商品登録
  def new
    @product = Product.new
  end

  # 商品作成
  def create
    @product = Product.new(product_params)
    @product.image.attach(params[:product][:image]) # 画像をアタッチする

    if @product.save
      redirect_to admin_product_path(@product), notice: '商品が登録されました。'
    else
      render :new
    end
  end

  # 商品編集
  def edit
  end

  # 商品削除
  def destroy
  end

  private

  def set_task
    @product = Product.find(params[:id])
    @products = Product.order(created_at: :desc).limit(4)
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
