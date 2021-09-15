class Place < ApplicationRecord
  validates :address, presence: true

  before_save :geocode

  private

  def geocode
    
  end
end
