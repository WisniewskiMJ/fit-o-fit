module Geocoders
  class GraphhopperGeocoder < GeocoderBase
    include OsmDictionary

    private

    def make_request
      self.response = Adapters::GraphhopperGeocodeAdapter.new(payload: payload).call
    end

    def payload
      place.address
    end

    def addresses_match?
      geocoder_address[:street].present? &&
        geocoder_address[:street].include?(translated_place_address[:street]) &&
        geocoder_address[:number] == translated_place_address[:number] &&
        geocoder_address[:town] == translated_place_address[:town] &&
        geocoder_address[:country] == translated_place_address[:country]
    end

    def response_latitude
      response_first['point']['lat']
    end

    def response_longitude
      response_first['point']['lng']
    end

    def translated_place_address
      place_address.transform_values { |value| OSM_DICTIONARY.key?(value) ? OSM_DICTIONARY[value] : value }
    end

    def geocoder_address
      {}.tap do |hash|
        hash[:street] = response_first['street'] if response_first.key?('street')
        hash[:number] = response_first['housenumber'] if response_first.key?('housenumber')
        hash[:town] = response_first['city'] if response_first.key?('city')
        hash[:country] = response_first['country'] if response_first.key?('country')
      end
    end

    def response_first
      response['hits'][0]
    end
  end
end
