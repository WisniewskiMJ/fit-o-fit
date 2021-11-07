# frozen_string_literal: true

module PlaceServices
  class PlaceGeocoder < ApplicationService
    def initialize(place)
      @place = place
    end

    def call
      geocoder_data = Google::Maps.geocode(@place.address).first

      if addresses_match?(geocoder_data.components)
        @place.latitude = geocoder_data.latitude
        @place.longitude = geocoder_data.longitude
        result = OpenStruct.new({ successfull?: true, payload: @place })
      else
        @place.errors.add :address, :address_faulty, message: 'couldn`t be matched with coordinates'
        result = OpenStruct.new({ successfull?: false, payload: @place })
      end
    end

    private

    def place_address
      parts = @place.address.split(',')
      street_address_parts = parts[0].split(' ')
      address_hash = { street: street_address_parts[0].strip,
                       number: street_address_parts[1].strip,
                       town: parts[1].strip,
                       country: parts[2].strip }
    end

    def geocoder_address(components)
      address_hash = {}
      address_hash[:street] = components['route'].first if components.key?('route')
      address_hash[:number] = components['street_number'].first if components.key?('street_number')
      address_hash[:town] = components['locality'].first if components.key?('locality')
      address_hash[:country] = components['country'].first if components.key?('country')
      address_hash
    end

    def addresses_match?(geocoder_data)
      place_address == geocoder_address(geocoder_data)
    end
  end
end
