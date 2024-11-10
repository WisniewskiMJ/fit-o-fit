module Geocoders
  class GmapsGeocoder < GeocoderBase
    private

    def make_request
      self.response ||= Google::Maps.geocode(@place.address).first
    end

    def addresses_match?
      place_address == geocoder_address
    end

    def geocoder_address
      address.tap do |hash|
        hash[:street] = components['route'].first if components.key?('route')
        hash[:number] = components['street_number'].first if components.key?('street_number')
        hash[:town] = components['locality'].first if components.key?('locality')
        hash[:country] = components['country'].first if components.key?('country')
      end
    end

    def components
      response.components
    end
  end
end
