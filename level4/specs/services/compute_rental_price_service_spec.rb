require './specs/shared/shared_data.rb'
require './services/compute_rental_price_service.rb'

RSpec.describe ComputeRentalPriceService do
  include_context 'rental'

  let(:service) { described_class.new(rental) }

  describe '#base_price' do
    subject { service.base_price }

    it 'should return the right rental base price' do
      expect(subject).to eq(duration * car.price_per_day + distance * car.price_per_km)
    end
  end

  describe '#duration_discount' do
    subject { service.duration_discount }

    context 'when duration lasts 1 day' do
      let(:duration) { 1 }

      it 'should return the right rental discount price' do
        expect(subject).to eq(0)
      end
    end

    context 'when duration lasts 6 days' do
      let(:duration) { 6 }

      it 'should return the right rental duration discount' do
        expect(subject).to eq(9)
      end
    end

    context 'when duration lasts 13 days' do
      let(:duration) { 13 }

      it 'should return the right rental duration discount' do
        expect(subject).to eq(36)
      end
    end
  end
end
