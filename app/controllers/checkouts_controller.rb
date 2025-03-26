class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_order, only: [:create]

  def create
    charge = Stripe::Charge.create(
      amount: (@order.total * 100).to_i,
      currency: 'cad',
      source: params[:stripeToken],
      description: "Order #{@order.id}"
    )
    
    @order.update(
      status: 'paid',
      stripe_charge_id: charge.id
    )
    
    OrderMailer.confirmation(@order).deliver_later
    clear_cart
    
    redirect_to order_path(@order), notice: 'Payment successful!'
  rescue Stripe::CardError => e
    @order.update(status: 'failed')
    redirect_to order_path(@order), alert: e.message
  end

  private
  
  def load_order
    @order = current_user.orders.find(params[:order_id])
  end
end