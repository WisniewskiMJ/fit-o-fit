class Place < ApplicationRecord
  validates :address, presence: true
  validates_format_of :address, with: /\A\s*\D+\s\d+\s*[,]\s*\D+\s*[,]\s*[a-zA-z]+\s*\z/
  
  #has_many :activities_started, ->(place) { where(start: place) }
  #has_many :activities_finished, ->(place) { where(finish: place) }
  has_many :activities_started,
  foreign_key: :start_id,
  class_name: :Activity

  has_many :activities_finished,
  foreign_key: :finish_id,
  class_name: :Activity

end
