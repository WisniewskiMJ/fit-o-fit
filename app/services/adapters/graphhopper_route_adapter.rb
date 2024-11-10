module Adapters
  class GraphhopperRouteAdapter
    def initialize(payload)
      @payload = payload
    end

    def call
      make_request
    end

    private

    attr_reader :payload
    attr_accessor :response

    def make_request
      self.response = HTTParty.post(url, headers: headers, query: query, body: body)
    end

    def url
      'https://graphhopper.com/api/1/route'
    end

    def headers
      { 'Content-Type' => 'application/json' }
    end

    def query
      {
        key: ENV['GRAPHHOPPER_API_KEY']
      }
    end

    def body
      {
        points: [
          [
            start_point[:longitude],
            start_point[:latitude]
          ],
          [
            finish_point[:longitude],
            finish_point[:latitude]
          ]
        ],
        profile: 'foot'
      }.to_json
    end

    def start_point
      payload[:start_point]
    end

    def finish_point
      payload[:finish_point]
    end
  end
end
