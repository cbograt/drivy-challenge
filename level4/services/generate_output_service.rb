class GenerateOutputService
  attr_reader :output_path, :data

  def initialize(output_path, data)
    @output_path = output_path
    @data = data
  end

  def call
    File.write(output_path, JSON.pretty_generate(data))
  end
end
