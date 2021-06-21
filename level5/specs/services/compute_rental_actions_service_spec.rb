require './specs/shared/shared_data.rb'

require './services/compute_rental_actions_service.rb'

RSpec.describe ComputeRentalActionsService do
  include_context 'commission'

  let(:action_driver) { 'action_driver' }
  let(:action_owner) { 'action_owner' }
  let(:action_insurance) { 'action_insurance' }
  let(:action_assistance) { 'action_assistance' }
  let(:action_drivy) { 'action_drivy' }

  let(:service) { described_class.new(commission) }

  before do
    allow(Action).to receive(:new).with('driver', 'debit', 27_800).and_return(action_driver)
    allow(Action).to receive(:new).with('owner', 'credit', 19_460).and_return(action_owner)
    allow(Action).to receive(:new).with('insurance', 'credit', 4_170).and_return(action_insurance)
    allow(Action).to receive(:new).with('assistance', 'credit', 1_200).and_return(action_assistance)
    allow(Action).to receive(:new).with('drivy', 'credit', 2_970).and_return(action_drivy)
  end

  describe '#call' do
    subject { service.call }

    it 'should return the right actions' do
      expect(subject).to eq([action_driver, action_owner, action_insurance, action_assistance, action_drivy])
    end
  end
end
