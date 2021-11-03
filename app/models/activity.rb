class Activity < ApplicationRecord
  validates :start_id, presence: true
  validates :finish_id, presence: true
  validates :distance, presence: true
  validates :day, presence: true

  belongs_to :start,
  foreign_key: :start_id,
  class_name: :Place

  belongs_to :finish,
  foreign_key: :finish_id,
  class_name: :Place

  belongs_to :user

end
