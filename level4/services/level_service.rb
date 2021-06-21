require './database.rb'
require './services/generate_output_service.rb'

class LevelService
  attr_reader :output_path

  def initialize(input_path, output_path)
    @output_path = output_path
    Database.load_from_file(input_path)
  end

  def call
    rentals = Database.fetch_collection(:rental)
    transformed_rentals = rentals.map { |rental| rental.as_json(%i[id actions]) }
    GenerateOutputService.new(output_path, rentals: transformed_rentals).call
  end
end
