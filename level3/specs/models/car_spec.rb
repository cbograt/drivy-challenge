require './models/car.rb'

RSpec.describe Car do
  let(:id) { 123 }
  let(:price_per_day) { 456 }
  let(:price_per_km) { 789 }
  let(:car) { Car.new(id: id, price_per_day: price_per_day, price_per_km: price_per_km) }

  shared_examples 'initialization' do
    subject { car }

    it 'returns the given properties' do
      expect(subject.id).to eq(id)
      expect(subject.price_per_day).to eq(price_per_day)
      expect(subject.price_per_km).to eq(price_per_km)
    end
  end

  describe '#initialize' do
    include_examples 'initialization'
  end

  describe '#build_from_hash' do
    let(:hash) do
      {
        id: id,
        price_per_day: price_per_day,
        price_per_km: price_per_km,
      }
    end

    let(:car) { Car.build_from_hash(hash) }

    include_examples 'initialization'
  end
end
