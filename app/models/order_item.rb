class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price_at_purchase, numericality: { greater_than: 0 }

  before_validation :set_price_at_purchase

  private

  def set_price_at_purchase
    self.price_at_purchase ||= product.current_price
  end
end