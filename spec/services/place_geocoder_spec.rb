require 'rails_helper'

RSpec.describe PlaceServices::PlaceGeocoder, type: :service do
  describe '#call', :vcr do
    let(:valid_place) { Place.new(address: 'Towarowa 2, Warszawa, Polska') }
    let(:invalid_place) { Place.new(address: 'Towarowa 1, Piecki, Polska') }

    context "place address matches received object's address" do
      let!(:result) { PlaceServices::PlaceGeocoder.call(place: valid_place) }
      it 'sets place coordinates to received coordinates' do
        expect(valid_place.latitude).to eq(52.22603085)
        expect(valid_place.longitude).to eq(20.9888595919274)
      end
      it 'returns openstruct containing success boolean and place object' do
        expect(result).to be_an_instance_of(OpenStruct)
        expect(result.successfull?).to be(true)
        expect(result.payload).to be(valid_place)
      end
    end

    context "place address does not match received object's address" do
      let!(:result) { PlaceServices::PlaceGeocoder.call(place: invalid_place) }
      it 'adds errors to place object' do
        expect(invalid_place.errors.full_messages).not_to be_empty
      end
      it 'returns openstruct containing failure boolean and place object' do
        expect(result).to be_an_instance_of(OpenStruct)
        expect(result.successfull?).to be(false)
        expect(result.payload).to be(invalid_place)
      end
    end
  end
end
