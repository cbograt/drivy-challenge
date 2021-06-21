require './models/base_model.rb'
require './services/compute_rental_actions_service.rb'
require './services/compute_rental_commissions_service.rb'
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

  def commission
    @commission ||= ComputeRentalCommissionsService.new(price, duration, options).call
  end

  def actions
    @actions ||= ComputeRentalActionsService.new(commission).call
  end

  def options
    @options ||= Option.find_all(:rental_id, id)
  end

  def price
    @price ||= ComputeRentalPriceService.new(self).call
  end

  def duration
    return @duration if @duration

    raise InvalidPeriodError if start_date.nil? || end_date.nil? || end_date < start_date

    @duration = (start_date..end_date).count
  end

  def price_for_duration
    @price_for_duration ||= duration * car.price_per_day
  end

  def price_for_distance
    @price_for_distance ||= distance * car.price_per_km
  end

  # delegates
  def price_per_day
    car.price_per_day
  end

  def price_per_km
    car.price_per_km
  end
end
