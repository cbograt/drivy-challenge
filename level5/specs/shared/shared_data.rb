require './models/car.rb'
require './models/commission.rb'
require './models/option.rb'
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
  let(:owner_fee) { 19_460 }
  let(:insurance_fee) { 4_170 }
  let(:assistance_fee) { 1_200 }
  let(:drivy_fee) { 2_970 }

  let(:commission) do
    Commission.new(
      driver_fee: driver_fee,
      owner_fee: owner_fee,
      insurance_fee: insurance_fee,
      assistance_fee: assistance_fee,
      drivy_fee: drivy_fee
    )
  end
end

shared_context 'option' do
  let(:id) { 1 }
  let(:rental_id) { 1 }
  let(:option_gps) { Option.new(id: id, rental_id: rental_id, type: 'gps') }
  let(:option_baby_seat) { Option.new(id: id, rental_id: rental_id, type: 'baby_seat') }
  let(:option_additional_insurance) { Option.new(id: id, rental_id: rental_id, type: 'additional_insurance') }
end
