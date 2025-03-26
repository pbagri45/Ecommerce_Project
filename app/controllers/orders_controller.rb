class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_cart_items, only: [:new, :create]
  before_action :set_order, only: [:show]

  def new
    @order = current_user.orders.build
    @provinces = Province.all
    @subtotal = calculate_subtotal(@cart_items)
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = 'pending'
    set_order_totals(@order)

    if @order.save
      create_order_items(@order)
      process_payment(@order)
    else
      @provinces = Province.all
      @subtotal = calculate_subtotal(@cart_items)
      render :new
    end
  end

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order_items = @order.order_items.includes(:product)
  end

  private

  # ... (private methods for order processing)
end