class Product < ApplicationRecord
    has_many :product_categories, dependent: :destroy
    has_many :categories, through: :product_categories
    has_many :order_items
    has_one_attached :image
  
    validates :name, :description, :price, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
    scope :on_sale, -> { where(on_sale: true) }
    scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
    scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }
  
    before_save :set_current_price
  
    private
  
    def set_current_price
      self.current_price = on_sale? ? price * 0.9 : price
    end
  end