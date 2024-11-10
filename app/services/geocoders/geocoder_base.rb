module Geocoders
  class GeocoderBase < ApplicationService
    def initialize(place:)
      @place = place
    end

    def call
      make_request
      result
    end

    private

    attr_accessor :place, :response

    def make_request
      raise NotImplementedError
    end

    def result
      if addresses_match?
        place.latitude = response_latitude
        place.longitude = response_longitude
        OpenStruct.new({ successfull?: true, payload: place })
      else
        place.errors.add :address, :address_faulty, message: 'couldn`t be matched with coordinates'
        OpenStruct.new({ successfull?: false, payload: place })
      end
    end

    def addresses_match?
      raise NotImplementedError
    end

    def response_latitude
      raise NotImplementedError
    end

    def response_longitude
      raise NotImplementedError
    end

    def place_address
      {
        street: street_address_parts[0].strip,
        number: street_address_parts[1].strip,
        town: address_parts[1].strip,
        country: address_parts[2].strip
      }
    end

    def address_parts
      place.address.split(',')
    end

    def street_address_parts
      address_parts[0].split
    end

    def geocoder_address
      raise NotImplementedError
    end

    def components
      response.components
    end
  end
end
