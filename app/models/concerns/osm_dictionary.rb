module OsmDictionary
  extend ActiveSupport::Concern

  OSM_DICTIONARY = {
    'Warszawa' => 'Warsaw',
    'Polska' => 'Poland',
    'Kraków' => 'Krakow'
  }.freeze
end
