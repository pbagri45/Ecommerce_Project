class Page < ApplicationRecord
    validates :title, :slug, :content, presence: true
    validates :slug, uniqueness: true
  
    before_validation :generate_slug
  
    private
  
    def generate_slug
      self.slug ||= title.parameterize if title
    end
  end