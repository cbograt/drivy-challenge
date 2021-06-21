require './models/commission.rb'

class ComputeRentalCommissionsService
  COMMISSION_RATE = 0.3
  INSURANCE_RATE = 0.5
  ASSISTANCE_FEE_PER_DAY = 100

  attr_reader :base_driver_fee, :duration, :options

  def initialize(base_driver_fee, duration, options = [])
    @base_driver_fee = base_driver_fee
    @duration = duration
    @options = options
  end

  def call
    Commission.new(
      driver_fee: driver_fee,
      owner_fee: owner_fee,
      insurance_fee: insurance_fee,
      assistance_fee: assistance_fee,
      drivy_fee: drivy_fee
    )
  end

  def driver_fee
    @driver_fee ||= base_driver_fee + owner_options_fee + drivy_options_fee
  end

  def owner_fee
    @owner_fee ||= base_driver_fee - total_commission + owner_options_fee
  end

  def total_commission
    @total_commission ||= base_driver_fee * COMMISSION_RATE
  end

  def insurance_fee
    @insurance_fee ||= total_commission * INSURANCE_RATE
  end

  def assistance_fee
    @assistance_fee ||= duration * ASSISTANCE_FEE_PER_DAY
  end

  def drivy_fee
    @drivy_fee ||= total_commission - insurance_fee - assistance_fee + drivy_options_fee
  end

  def owner_options_fee
    @owner_options_fee ||= compute_options_fees(options.select(&:owner_option?))
  end

  def drivy_options_fee
    @drivy_options_fee ||= compute_options_fees(options.select(&:drivy_option?))
  end

  def compute_options_fees(options)
    options.inject(0) { |res, option| res + option.fee_for_duration(duration) }
  end
end
