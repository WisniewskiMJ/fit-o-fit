class Activity < ApplicationRecord
  validates :start, presence: true
  validates :finish, presence: true
  validates :distance, presence: true
  validates :day, presence: true

  belongs_to :start,
  class_name: :Place

  belongs_to :finish,
  class_name: :Place

  belongs_to :user

  before_validation :set_distance

  private

  def set_distance
    distance = Google::Maps.distance_matrix(start.address, finish.address).distance
    self.distance = (distance / 1000.0).round(2)
  end
end
