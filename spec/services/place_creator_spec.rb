require 'rails_helper'

RSpec.describe PlaceServices::PlaceCreator, type: :service do
  describe '#call', :vcr do
    context 'with valid address' do
      context 'address exists' do
        let(:existent_address) { 'Towarowa 1, Warszawa, Polska'}
        it 'adds place to database' do
          expect{ PlaceServices::PlaceCreator.new(existent_address).call }.to change { Place.count }.by(1)
        end
        it 'returns openstruct containing success boolean and place object' do
          result = PlaceServices::PlaceCreator.new(existent_address).call
          place = Place.find_by(address: existent_address)
          expect(result).to be_an_instance_of(OpenStruct)
          expect(result.created?).to be(true)
          expect(result[:payload]).to eq(place)
        end
      end
      context 'adress does not exist' do
        let(:inexistent_address) { 'Towarowa 1, Piecki, Polska '}
        let(:inexistent_place) { Place.new(address: inexistent_address) }
        let(:result) { PlaceServices::PlaceCreator.new(inexistent_address).call }
        it 'does not add place to database' do
          expect{ PlaceServices::PlaceCreator.new(inexistent_address).call }.not_to change { Place.count }
        end
        it 'adds errors to place object' do
          expect(result.payload.errors.full_messages).not_to be_empty
        end
        it 'returns openstruct containing failure boolean and place object' do
          expect(result).to be_an_instance_of(OpenStruct)
          expect(result.created?).to be(false)
          expect(result[:payload]).to be_an_instance_of(Place)
        end
      end
    end

    context 'with invalid address' do
      let(:invalid_address) { 'Towarowa 1, Piecki '}
      let(:result) { PlaceServices::PlaceCreator.new(invalid_address).call }
       it 'does not add place to database' do
          expect{ PlaceServices::PlaceCreator.new(invalid_address).call }.not_to change { Place.count }
        end
        it 'adds errors to place object' do
          expect(result.payload.errors.full_messages).not_to be_empty
        end
        it 'returns openstruct containing failure boolean and place object' do
          expect(result).to be_an_instance_of(OpenStruct)
          expect(result.created?).to be(false)
          expect(result[:payload]).to be_an_instance_of(Place)
        end
    end
  end
end