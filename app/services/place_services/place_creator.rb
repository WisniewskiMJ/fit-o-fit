module PlaceServices  
  class PlaceCreator < ApplicationService
    def initialize(address)
      @address = address
    end

    def call
      place = Place.new(address: @address)
      if place.valid?
        geocode = PlaceServices::PlaceGeocoder.call(place)
        if geocode.successfull?
          place = geocode.payload
          place.save
          result = OpenStruct.new({created?: true, payload: place})
        else
          place.errors.add :base, :address_mismatched, message: geocode.payload.errors.full_messages
          result = OpenStruct.new({created?: false, payload: place})
        end
      else
        result = OpenStruct.new({created?: false, payload: place})
      end
    end
  end
end