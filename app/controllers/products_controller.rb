# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    @products = Product.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show; 
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @product = Product.find(params[:id])
    @products = Product.all
  end
end
