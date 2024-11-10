module ActivityServices
  class DistanceFinder < ApplicationService
    def initialize(start_point:, finish_point:)
      @start_point = start_point
      @finish_point = finish_point
    end

    def call
      make_request
      distance_in_km
    end

    private

    attr_reader :start_point, :finish_point
    attr_accessor :response

    def make_request
      self.response = Adapters::GraphhopperRouteAdapter.new(payload).call
    end

    def distance_in_km
      (distance / 1000.0).round(2)
    end

    def distance
      response['paths'][0]['distance']
    end

    def payload
      {
        start_point: start_point,
        finish_point: finish_point
      }
    end
  end
end
