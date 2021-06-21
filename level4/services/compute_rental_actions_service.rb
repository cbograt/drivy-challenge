require './models/action.rb'

class ComputeRentalActionsService
  TYPE_CREDIT = 'credit'.freeze
  TYPE_DEBIT = 'debit'.freeze

  CREDIT_KEYS = %w[owner insurance assistance drivy].freeze
  DEBIT_KEYS = %w[driver].freeze

  def initialize(commission)
    @commission = commission
  end

  def call
    build_debit_actions + build_credit_actions
  end

  private

  attr_reader :commission

  def build_credit_actions
    CREDIT_KEYS.map { |who| build_action(who, TYPE_CREDIT) }
  end

  def build_debit_actions
    DEBIT_KEYS.map { |who| build_action(who, TYPE_DEBIT) }
  end

  def build_action(who, type)
    amount = commission.send("#{who}_fee").to_i
    Action.new(who, type, amount)
  end
end
