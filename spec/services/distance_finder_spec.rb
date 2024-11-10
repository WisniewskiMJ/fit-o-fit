require 'rails_helper'

RSpec.describe ActivityServices::DistanceFinder, type: :service do
  let(:start) do
    create(:place, address: start_address,
                   latitude: 52.2264294,
                   longitude: 20.987053)
  end
  let(:start_address) { 'Towarowa 3, Warszawa, Polska' }
  let(:finish) do
    create(:place, address: finish_address,
                   latitude: 52.2494588,
                   longitude: 20.99787875814951)
  end
  let(:finish_address) { 'Puławska 35, Warszawa, Polska' }

  describe '#call', :vcr do
    it 'returns the distance between two points in kilometers' do
      distance = ActivityServices::DistanceFinder.call(start_point: start, finish_point: finish)
      expect(distance).to eq(3.51)
    end
  end
end
