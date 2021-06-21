require './models/car.rb'
require './models/rental.rb'

shared_context 'rental' do
  let(:id) { 1 }
  let(:car_id) { 2 }
  let(:duration) { 3 }
  let(:start_date) { (Date.today - duration + 1).to_s }
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
end

shared_context 'commission' do
  let(:driver_fee) { 27_800 }
  let(:duration) { 12 }
  let(:commission) { Commission.new(driver_fee, duration) }
end
