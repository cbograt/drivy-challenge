require './models/base_model.rb'

class Commission < BaseModel
  COMMISSION_RATE = 0.3
  INSURANCE_RATE = 0.5
  ASSISTANCE_FEE_PER_DAY = 100

  attr_reader :driver_fee, :duration

  def initialize(driver_fee, duration)
    @driver_fee = driver_fee
    @duration = duration
  end

  def owner_fee
    @owner_fee ||= driver_fee - total_commission
  end

  def total_commission
    @total_commission ||= driver_fee * COMMISSION_RATE
  end

  def insurance_fee
    @insurance_fee ||= total_commission * INSURANCE_RATE
  end

  def assistance_fee
    @assistance_fee ||= duration * ASSISTANCE_FEE_PER_DAY
  end

  def drivy_fee
    @drivy_fee ||= total_commission - insurance_fee - assistance_fee
  end

  protected

  def default_json_attributes
    %i[insurance_fee assistance_fee drivy_fee]
  end
end
