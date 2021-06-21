require './models/base_model.rb'

class Commission < BaseModel
  COMMISSION_RATE = 0.3
  INSURANCE_RATE = 0.5
  ASSISTANCE_FEE_PER_DAY = 100

  attr_reader :base_price, :duration

  def initialize(base_price, duration)
    @base_price = base_price
    @duration = duration
  end

  def total_commission
    @total_commission ||= base_price * COMMISSION_RATE
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
