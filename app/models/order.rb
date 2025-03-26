class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum status: { pending: 'pending', paid: 'paid', shipped: 'shipped', cancelled: 'cancelled' }

  validates :status, presence: true
  validates :subtotal, :total, numericality: { greater_than_or_equal_to: 0 }
  validates :gst_amount, :pst_amount, :hst_amount, numericality: { greater_than_or_equal_to: 0 }

  before_validation :calculate_totals

  private

  def calculate_totals
    self.subtotal ||= order_items.sum { |item| item.price_at_purchase * item.quantity }
    self.total ||= subtotal + gst_amount + pst_amount + hst_amount
  end
end