require './models/base_model.rb'
require './services/compute_rental_price_service.rb'
require 'date'

class Rental < BaseModel
  class InvalidPeriodError < StandardError
  end

  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(id:, car_id:, start_date:, end_date:, distance:)
    @id = id
    @car_id = car_id
    @start_date = Date.parse(start_date) if start_date
    @end_date = Date.parse(end_date) if end_date
    @distance = distance
  end

  def car
    @car ||= Car.find(car_id)
  end

  def period
    raise InvalidPeriodError if start_date.nil? || end_date.nil? || end_date < start_date

    (start_date..end_date).count
  end

  def price_for_period
    period * car.price_per_day
  end

  def price_for_distance
    distance * car.price_per_km
  end

  def price
    @price ||= ComputeRentalPriceService.new(self).call
  end

  # delegates
  def price_per_day
    car.price_per_day
  end

  def price_per_km
    car.price_per_km
  end
end
