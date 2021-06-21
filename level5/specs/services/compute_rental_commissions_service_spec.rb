require './specs/shared/shared_data.rb'

RSpec.describe ComputeRentalCommissionsService do
  include_context 'option'

  let(:base_driver_fee) { 27_800 }
  let(:duration) { 12 }
  let(:options) { [option_gps, option_baby_seat, option_additional_insurance] }
  let(:service) { described_class.new(base_driver_fee, duration, options) }
  let(:commission) { service.call }

  describe '#driver_fee' do
    subject { commission.driver_fee }

    it 'returns the right driver_fee' do
      expect(subject).to eq(48_200)
    end
  end

  describe '#owner_fee' do
    subject { commission.owner_fee }

    it 'returns the right owner_fee' do
      expect(subject).to eq(27_860)
    end
  end

  describe '#insurance_fee' do
    subject { commission.insurance_fee }

    it 'returns the right insurance_fee' do
      expect(subject).to eq(4_170)
    end
  end

  describe '#assistance_fee' do
    subject { commission.assistance_fee }

    it 'returns the right assistance_fee' do
      expect(subject).to eq(1_200)
    end
  end

  describe '#drivy_fee' do
    subject { commission.drivy_fee }

    it 'returns the right drivy_fee' do
      expect(subject).to eq(14_970)
    end
  end
end
