require_relative "unveiler/encoder"

class Unveiler
  def self.encode(input_file, output_file, data)
    encoder = Encoder.new
    encoder.encode(input_file, output_file, data)
  end
end
