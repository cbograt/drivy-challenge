require './specs/shared/shared_data.rb'

RSpec.describe Rental do
  include_context 'rental'

  shared_examples 'invalid date' do
    it 'raises a ArgumentError' do
      expect { subject }.to raise_error(ArgumentError)
    end
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

    context 'when start_date is not valid' do
      let(:start_date) { '1234-56-78' }

      include_examples 'invalid date'
    end

    context 'when end_date is not valid' do
      let(:end_date) { '1234-56-78' }

      include_examples 'invalid date'
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

    shared_examples 'invalid period' do
      it 'raises a InvalidPeriodError' do
        expect { subject }.to raise_error(Rental::InvalidPeriodError)
      end
    end

    context 'when start_date is nil' do
      let(:start_date) { nil }

      include_examples 'invalid period'
    end

    context 'when end_date is nil' do
      let(:end_date) { nil }

      include_examples 'invalid period'
    end

    context 'when end_date is before start_date' do
      let(:end_date) { (Date.parse(start_date) - 1).to_s }

      include_examples 'invalid period'
    end

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
      it 'returns nil' do expect(subject).to eq(nil) end
    end

    context 'when price components are valid' do
      let(:compute_rental_price_service) { instance_double(ComputeRentalPriceService, call: 1) }

      before { allow(ComputeRentalPriceService).to receive(:new).with(rental).and_return(compute_rental_price_service) }

      it 'should call ComputeRentalPriceService' do
        expect(compute_rental_price_service).to receive(:call)
        subject
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
    subject do
      rental.to_json([:id, :price])
    end

    context 'with id and price as arguments' do
      it 'should return a json with id and price' do
        expect(subject).to eq("{\"id\":1,\"price\":1028}")
      end
    end
  end
end
