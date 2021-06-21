require './specs/shared/shared_data.rb'

require './models/option.rb'

RSpec.describe Option do
  include_context 'option'

  describe '#fee_for_duration' do
    let(:duration) { 10 }

    subject { option.fee_for_duration(duration) }

    context 'when option is a gps' do
      let(:option) { option_gps }
      it 'returns the right gps fees' do
        expect(subject).to eq(duration * 500)
      end
    end

    context 'when option is a baby_seat' do
      let(:option) { option_baby_seat }
      it 'returns the right baby_seat fees' do
        expect(subject).to eq(duration * 200)
      end
    end

    context 'when option is an additional_insurance' do
      let(:option) { option_additional_insurance }
      it 'returns the right additional_insurance fees' do
        expect(subject).to eq(duration * 1000)
      end
    end
  end
end
