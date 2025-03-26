class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :initialize_cart, only: [:add_to_cart]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:categories).page(params[:page]).per(12)
    
    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def show
    @related_products = @product.categories.first.products.where.not(id: @product.id).limit(4)
  end

  def add_to_cart
    product_id = params[:id].to_s
    quantity = params[:quantity] || 1
    
    session[:cart][product_id] ||= 0
    session[:cart][product_id] += quantity.to_i
    
    redirect_back fallback_location: root_path, 
                 notice: "#{@product.name} added to cart"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found"
  end
end