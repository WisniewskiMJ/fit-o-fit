module PlaceServices
  class PlaceCreator < ApplicationService
    def initialize(address:)
      @address = address
    end

    def call
      place = Place.new(address: address)
      if place.valid?
        geocode = PlaceServices::PlaceGeocoder.call(place: place)
        if geocode.successfull?
          place = geocode.payload
          place.save
          OpenStruct.new({ created?: true, payload: place })
        else
          place.errors.add :base, :address_mismatched, message: geocode.payload.errors.full_messages
          OpenStruct.new({ created?: false, payload: place })
        end
      else
        OpenStruct.new({ created?: false, payload: place })
      end
    end

    private

    attr_reader :address
  end
end
