require './specs/shared/shared_data.rb'
require './services/compute_rental_price_service.rb'

RSpec.describe ComputeRentalPriceService do
  include_context 'rental'

  let(:service) { described_class.new(rental) }

  describe '#base_price' do
    subject { service.base_price }

    it 'should return the right rental base price' do
      expect(subject).to eq(period * car.price_per_day + distance * car.price_per_km)
    end
  end

  describe '#period_discount' do
    subject { service.period_discount }

    context 'when period lasts 1 day' do
      let(:period) { 1 }

      it 'should return the right rental discount price' do
        expect(subject).to eq(0)
      end
    end

    context 'when period lasts 6 days' do
      let(:period) { 6 }

      it 'should return the right rental period discount' do
        expect(subject).to eq(9)
      end
    end

    context 'when period lasts 13 days' do
      let(:period) { 13 }

      it 'should return the right rental period discount' do
        expect(subject).to eq(36)
      end
    end
  end
end
