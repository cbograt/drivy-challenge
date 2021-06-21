require './database.rb'

RSpec.describe Database do
  let(:car) { Car.new(id: 1, price_per_day: 2, price_per_km: 3) }
  let(:cars) { [car] }

  describe '#find' do
    let(:id) { car.id }

    subject { Database.find(collection_key, id) }

    before do
      Database.register_collection(:cars, cars)
    end

    context 'when collection does not exist' do
      let(:collection_key) { :key }

      it 'raises a CollectionNotFoundError' do
        expect { subject }.to raise_error(Database::CollectionNotFoundError)
      end
    end

    context 'when exists' do
      let(:collection_key) { :cars }

      context 'when item does not exist' do
        let(:id) { 0 }

        it 'raises a CollectionNotFoundError' do
          expect { subject }.to raise_error(Database::RecordNotFoundError)
        end
      end

      context 'when item exists' do
        it 'returns the item' do
          item = subject
          expect(item.id).to eq(car.id)
        end
      end
    end
  end
end
