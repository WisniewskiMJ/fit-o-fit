# frozen_string_literal: true

module PlaceServices
  class PlaceGeocoder < ApplicationService
    def initialize(place:)
      @place = place
    end

    def call
      return gmaps_geocode if gmaps_api_key_present?

      graphhopper_geocode
    end

    private

    attr_reader :place

    def gmaps_geocode
      Geocoders::GmapsGeocoder.call(place: place)
    end

    def graphhopper_geocode
      Geocoders::GraphhopperGeocoder.call(place: place)
    end

    def gmaps_api_key_present?
      ENV['GMAPS_API_KEY'].present?
    end
  end
end
