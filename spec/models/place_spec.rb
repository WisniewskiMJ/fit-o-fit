require 'rails_helper'

RSpec.describe Place, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to allow_value('Towarowa 1, Warszawa, Polska').for(:address) }
    it { is_expected.to_not allow_value('Towarowa 1, Warszawa').for(:address) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:activities_started) }
    it { is_expected.to have_many(:activities_finished) }
  end
end
