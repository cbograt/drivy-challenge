require './models/rental.rb'

RSpec.describe Rental do
  let(:id) { 1 }
  let(:car_id) { 2 }
  let(:period) { 3 }
  let(:start_date) { (Date.today - period + 1).to_s }
  let(:end_date) { Date.today.to_s }
  let(:distance) { 100 }
  let(:price_per_day) { 10 }
  let(:price_per_km) { 10 }
  let(:rental) do
    Rental.new(
      id: id,
      car_id: car_id,
      start_date: start_date,
      end_date: end_date,
      distance: distance
    )
  end
  let(:car) { Car.new(id: car_id, price_per_day: price_per_day, price_per_km: price_per_km) }

  before do
    allow(Car).to receive(:find).with(car_id).and_return(car)
  end

  shared_examples 'initialization' do
    subject { rental }

    it 'returns the given properties' do
      expect(subject.id).to eq(id)
      expect(subject.car_id).to eq(car_id)
      expect(subject.start_date).to eq(Date.parse(start_date))
      expect(subject.end_date).to eq(Date.parse(end_date))
      expect(subject.distance).to eq(distance)
    end
  end

  describe '#initialize' do
    include_examples 'initialization'
  end

  describe '#build_from_hash' do
    let(:hash) do
      {
        id: id,
        car_id: car_id,
        start_date: start_date,
        end_date: end_date,
        distance: distance
      }
    end

    let(:rental) { Rental.build_from_hash(hash) }

    include_examples 'initialization'
  end

  describe '#car' do
    subject { rental.car }

    it 'should return the right car' do
      expect(subject).to eq(car)
    end
  end

  describe '#period' do
    subject { rental.period }

    it 'should return the right rental period' do
      expect(subject).to eq(period)
    end
  end

  describe '#price_for_period' do
    subject { rental.price_for_period }

    it 'should return the right price for the rental period' do
      expect(subject).to eq(period * car.price_per_day)
    end
  end

  describe '#price_for_distance' do
    subject { rental.price_for_distance }

    it 'should return the right price for the rental distance' do
      expect(subject).to eq(distance * car.price_per_km)
    end
  end

  describe '#price' do
    subject { rental.price }

    shared_examples 'invalid price' do
      it 'returns nil' do
        expect(subject).to eq(nil)
      end
    end
    context 'when price components are valid' do
      it 'should return the right rental price' do
        expect(subject).to eq(period * car.price_per_day + distance * car.price_per_km)
      end
    end

    context 'when distance is not valid' do
      let(:distance) { nil }

      include_examples 'invalid price'
    end

    context 'when price_per_km is not valid' do
      let(:price_per_km) { nil }

      include_examples 'invalid price'
    end

    context 'when price_per_day is not valid' do
      let(:price_per_day) { nil }

      include_examples 'invalid price'
    end
  end

  describe '#to_json' do
    subject { rental.to_json([:id, :price]) }

    context 'with id and price as arguments' do
      it 'should return a json with id and price' do
        expect(subject).to eq("{\"id\":1,\"price\":1030}")
      end
    end
  end
end
