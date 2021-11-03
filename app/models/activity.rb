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

end
