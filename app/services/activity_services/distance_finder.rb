module ActivityServices
  class DistanceFinder < ApplicationService
    def initialize(start, finish)
      @start = start
      @finish = finish
    end

    def call
      distance = Google::Maps.distance_matrix(@start, @finish, {mode: :walking}).distance
      distance_km = (distance / 1000.0).round(2)
    end
  end
end