require './models/base_model.rb'

class Commission < BaseModel
  attr_reader :driver_fee, :owner_fee, :insurance_fee, :assistance_fee, :drivy_fee

  def initialize(driver_fee:, owner_fee:, insurance_fee:, assistance_fee:, drivy_fee:)
    @driver_fee = driver_fee
    @owner_fee = owner_fee
    @insurance_fee = insurance_fee
    @assistance_fee = assistance_fee
    @drivy_fee = drivy_fee
  end

  protected

  def default_json_attributes
    %i[insurance_fee assistance_fee drivy_fee]
  end
end
