require 'rails_helper'

RSpec.describe PlaceServices::PlaceCreator, type: :service do
  describe '#call', :vcr do
    subject(:creator_call) { described_class.call(address: address) }
    context 'with valid address' do
      context 'address exists' do
        let(:address) { 'Towarowa 2, Warszawa, Polska' }
        let(:place) { create(:place, address: address) }
        it 'adds place to database' do
          expect { creator_call }.to change { Place.count }.by(1)
        end
        it 'returns openstruct containing success boolean and place object' do
          result = creator_call
          expect(result).to be_an_instance_of(OpenStruct)
          expect(result.created?).to be(true)
        end
      end
      context 'adress does not exist' do
        let(:address) { 'Towarowa 1, Piecki, Polska ' }
        let(:inexistent_place) { Place.new(address: place) }
        let(:result) { creator_call }
        it 'does not add place to database' do
          expect { creator_call }.not_to(change { Place.count })
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
      let(:address) { 'Towarowa 1, Piecki ' }
      let(:result) { creator_call }
      it 'does not add place to database' do
        expect { creator_call }.not_to(change { Place.count })
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
