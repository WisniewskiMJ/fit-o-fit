class Activity < ApplicationRecord
  validates :start, presence: true
  validates :finish, presence: true
  validates :distance, presence: true

  has_one :start,
  class_name: :Place

  has_one :finish,
  class_name: :Place

  belongs_to :user

  before_validation :set_distance

  private

  def set_distance
    distance = Google::Maps.distance_matrix(start.address, finish.address).distance
  end
end
