require './specs/shared/shared_data.rb'

require './models/commission.rb'

RSpec.describe Commission do
  include_context 'commission'

  describe '#total_commission' do
    subject { commission.total_commission }

    it 'returns the right total_commission' do
      expect(subject).to eq(8_340)
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
