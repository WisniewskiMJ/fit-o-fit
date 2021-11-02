module PlaceServices
  class PlaceGeocoder < ApplicationService
    def initialize(place)
      @place = place
    end

    def call
      place_data = Google::Maps.geocode(@place.address).first 
      components = place_data.components
      street = components["route"].first if components.has_key?("route")
      number = components["street_number"].first if components.has_key?("street_number")
      town = components["locality"].first if components.has_key?("locality")
      country = components["country"].first if components.has_key?("country")
      if street == address_split[:street] && number == address_split[:number] &&
          town == address_split[:town] && country == address_split[:country] 
      
        coordinates = { latitude: place_data.latitude, longitude: place_data.longitude }
        result = OpenStruct.new({ successfull?: true, coordinates: coordinates})
      else
        error = "Address couldn`t be matched with coordinates"
        result = OpenStruct.new({ successfull?: false, error: error})
      end
    end

    private

    def address_split
      parts = @place.address.split(",")
      street_address_parts = parts[0].split(" ")
      address_hash = { street: street_address_parts[0].strip,
                      number: street_address_parts[1].strip,
                      town: parts[1].strip,
                      country: parts[2].strip
      }
    end
  end
end