class Place < ApplicationRecord
  validates :address, presence: true
  validates :latitude, presence: { message: "Specify valid address" }

  belongs_to :activity

  before_validation :geocode

  private

  def geocode
    place_data = Google::Maps.geocode(address).first

    street = place_data.components["route"].first
    number = place_data.components["street_number"].first
    town = place_data.components["locality"].first
    country = place_data.components["country"].first

    if street == address_split[:street] &&
       number == address_split[:number] &&
       town == address_split[:town] && 
       country == address_split[:country] 
        self.latitude = place_data.latitude
        self.longitude = place_data.longitude
    end
    
  end

  def address_split
    parts = address.split(",")
    street_address_parts = parts[0].split(" ")
    address_hash = { street: street_address_parts[0].strip,
                     number: street_address_parts[1].strip,
                     town: parts[1].strip,
                     country: parts[2].strip
    }
  end

end
