class CartsController < ApplicationController
  before_action :initialize_cart
  before_action :validate_quantity, only: [:update]

  def show
    @cart_items = load_cart_items
    @subtotal = calculate_subtotal(@cart_items)
  end

  def update
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][product_id] = quantity
    else
      session[:cart].delete(product_id)
    end

    redirect_to cart_path, notice: "Cart updated"
  end

  def destroy
    session[:cart] = {}
    redirect_to cart_path, notice: "Cart cleared"
  end

  private

  def load_cart_items
    session[:cart].map do |product_id, quantity|
      product = Product.find(product_id)
      {
        product: product,
        quantity: quantity,
        total: product.current_price * quantity
      }
    end
  end

  def calculate_subtotal(items)
    items.sum { |item| item[:total] }
  end

  def validate_quantity
    unless params[:quantity].to_i.positive?
      redirect_to cart_path, alert: "Quantity must be at least 1"
    end
  end
end