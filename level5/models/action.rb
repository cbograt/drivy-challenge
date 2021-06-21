require './models/base_model.rb'

class Action < BaseModel
  attr_reader :who, :type, :amount

  def initialize(who, type, amount)
    @who = who
    @type = type
    @amount = amount
  end

  protected

  def default_json_attributes
    %i[who type amount]
  end
end
