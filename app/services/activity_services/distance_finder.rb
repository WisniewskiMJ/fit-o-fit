module ActivityServices
  class DistanceFinder < ApplicationService
    def initialize(start_address, finish_address)
      @start_address = start_address
      @finish_address = finish_address
    end

    def call
      distance = Google::Maps.distance_matrix(@start_address, @finish_address, {mode: :walking})
                             .distance
      distance_km = (distance / 1000.0).round(2)
    end
  end
end