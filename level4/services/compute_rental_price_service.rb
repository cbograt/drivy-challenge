class ComputeRentalPriceService
  DISCOUNT_RATES = [
    {
      min_days: 1,
      discount: 0.1
    },
    {
      min_days: 4,
      discount: 0.3
    },
    {
      min_days: 10,
      discount: 0.5
    },
  ].freeze

  def initialize(rental)
    @rental = rental
  end

  def call
    (base_price - duration_discount).to_i
  rescue
    nil
  end

  def base_price
    @base_price ||= rental.price_for_duration + rental.price_for_distance
  end

  def duration_discount
    duration = rental.duration
    @duration_discount ||= desc_discount_rates.inject(0) do |res, discount_rate|
      if duration > discount_rate[:min_days]
        delta = duration - discount_rate[:min_days]
        duration -= delta
        res + delta * discount_rate[:discount] * rental.price_per_day
      else
        res
      end
    end
  end

  private

  attr_reader :rental

  def desc_discount_rates
    DISCOUNT_RATES.sort_by { |discount_rate| -discount_rate[:min_days] }
  end
end
