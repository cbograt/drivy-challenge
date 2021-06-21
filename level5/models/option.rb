require './models/base_model.rb'

class Option < BaseModel
  OWNER_OPTIONS_FEE_PER_DAY = {
    'gps': 500,
    'baby_seat': 200
  }.freeze

  DRIVY_OPTIONS_FEE_PER_DAY = {
    'additional_insurance': 1000
  }.freeze

  OPTIONS_FEE_PER_DAY = OWNER_OPTIONS_FEE_PER_DAY.merge(DRIVY_OPTIONS_FEE_PER_DAY).freeze

  attr_reader :id, :rental_id, :type

  def initialize(id:, rental_id:, type:)
    @id = id
    @rental_id = rental_id
    @type = type
  end

  def as_json
    type
  end

  def fee_for_duration(duration)
    return 0 unless duration

    duration * OPTIONS_FEE_PER_DAY[type.to_sym]
  end

  def owner_option?
    OWNER_OPTIONS_FEE_PER_DAY.key?(type.to_sym)
  end

  def drivy_option?
    DRIVY_OPTIONS_FEE_PER_DAY.key?(type.to_sym)
  end

  protected

  def default_json_attributes
    %i[type]
  end
end
