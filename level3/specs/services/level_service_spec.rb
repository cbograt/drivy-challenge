require 'tempfile'

require './services/level_service.rb'

RSpec.describe LevelService do
  let(:tempfile) { Tempfile.new }
  let(:service) { described_class.new('./specs/fixtures/input.json', tempfile.path) }
  let(:expected_json) do
    JSON.parse(File.read('./specs/fixtures/expected_output.json'))
  end

  describe '#call' do
    subject { service.call }

    before do
      subject
    end

    after do
      File.delete(tempfile.path) if File.exist?(tempfile.path)
    end

    it 'should generate the expected output' do
      expect(JSON.parse(File.read(tempfile.path))).to eq(expected_json)
    end
  end
end
