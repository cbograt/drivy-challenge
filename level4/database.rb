require 'json'
require './models/car.rb'
require './models/rental.rb'

class Database
  class CollectionNotFoundError < StandardError
  end

  class RecordNotFoundError < StandardError
  end

  class << self
    def collections
      @collections ||= {}
    end

    # Required to avoid loops on collections
    def indexed_collections
      @indexed_collections ||= {}
    end

    def register_collection(key, collection)
      collections[key] = collection
      index_collection(key)
    end

    def fetch_collection(key)
      collections[key]
    end

    def load_from_file(filepath)
      file = File.read(filepath)
      data = JSON.parse(file, symbolize_names: true)
      cars = data[:cars]&.map { |car_hash| Car.build_from_hash(car_hash) }
      register_collection(:car, cars)
      rentals = data[:rentals]&.map { |rental_hash| Rental.build_from_hash(rental_hash) }
      register_collection(:rental, rentals)
    end

    def find(collection_key, id)
      raise CollectionNotFoundError unless indexed_collections.key?(collection_key)

      collection = indexed_collections[collection_key]
      position = collection[id]
      raise RecordNotFoundError if position.nil?

      fetch_collection(collection_key)[position]
    end

    def index_collection(collection_key)
      indexed_collections[collection_key] = {}
      collection = fetch_collection(collection_key)
      collection.each_with_index do |item, i|
        indexed_collections[collection_key][item.id] = i
      end
    end
  end
end
