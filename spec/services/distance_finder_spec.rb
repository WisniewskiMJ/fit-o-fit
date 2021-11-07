require 'rails_helper'

RSpec.describe ActivityServices::DistanceFinder, type: :service do
  describe '#call', :vcr do
    it 'returns the distance between two points in kilometers' do
      start_address = 'Towarowa 1, Warszawa, Polska'
      finish_address = 'Marszałkowska 1, Warszawa, Polska'
      distance = ActivityServices::DistanceFinder.call(start_address, finish_address)
      expect(distance).to eq(3.04)  
    end
  end
end