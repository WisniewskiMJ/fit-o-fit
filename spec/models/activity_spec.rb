require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_id) }
    it { is_expected.to validate_presence_of(:finish_id) }
    it { is_expected.to validate_presence_of(:distance) }
    it { is_expected.to validate_presence_of(:day) }
  end

   describe 'associations' do
    it { is_expected.to belong_to(:start) }
    it { is_expected.to belong_to(:finish) }
    it { is_expected.to belong_to(:user) }
  end
end