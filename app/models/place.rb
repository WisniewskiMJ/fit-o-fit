class Place < ApplicationRecord
  validates :address, presence: true
  validates_format_of :address, with: /\A\s*\D+\s\d+\s*[,]\s*\D+\s*[,]\s*[a-zA-z]+\s*\z/
  
  has_many :activities
end
