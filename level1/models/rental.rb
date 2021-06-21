require './models/base_model.rb'
require 'date'

class Rental < BaseModel
  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(id:, car_id:, start_date:, end_date:, distance:)
    @id = id
    @car_id = car_id
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
  end

  def car
    @car ||= Car.find(car_id)
  end

  def period
    (start_date..end_date).count
  end

  def price_for_period
    period * car.price_per_day
  end

  def price_for_distance
    distance * car.price_per_km
  end

  def price
    price_for_period + price_for_distance
  rescue
    nil
  end
end
