require './specs/shared/shared_data.rb'

RSpec.describe Commission do
  include_context 'commission'

  describe '#driver_fee' do
    subject { commission.driver_fee }

    it 'returns the right driver_fee' do
      expect(subject).to eq(27_800)
    end
  end

  describe '#owner_fee' do
    subject { commission.owner_fee }

    it 'returns the right owner_fee' do
      expect(subject).to eq(19_460)
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
      expect(subject).to eq(2_970)
    end
  end
end
