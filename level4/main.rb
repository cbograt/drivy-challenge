require './services/level_service.rb'

INPUT_FILE_PATH = './data/input.json'.freeze
OUTPUT_FILE_PATH = './data/output.json'.freeze

LevelService.new(INPUT_FILE_PATH, OUTPUT_FILE_PATH).call
