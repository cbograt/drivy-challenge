require './services/level1_service.rb'

INPUT_FILE_PATH = './data/input.json'.freeze
OUTPUT_FILE_PATH = './data/output.json'.freeze

Level1Service.new(INPUT_FILE_PATH, OUTPUT_FILE_PATH).call
