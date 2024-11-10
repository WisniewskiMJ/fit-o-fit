module Adapters
  class GraphhopperGeocodeAdapter
    def initialize(payload:)
      @payload = payload
    end

    def call
      make_request
    end

    private

    attr_reader :payload
    attr_accessor :response

    def make_request
      self.response = HTTParty.get(url, query: query)
    end

    def url
      'https://graphhopper.com/api/1/geocode'
    end

    def query
      {
        q: payload,
        locale: 'en',
        limit: '5',
        reverse: 'false',
        debug: 'false',
        key: ENV['GRAPHHOPPER_API_KEY']
      }
    end
  end
end
