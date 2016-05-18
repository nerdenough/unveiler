require_relative "unveiler/encoder"

class Unveiler
  def self.encode(input_file, output_file, data)
    encoder = Encoder.new
    encoder.encode(input_file, output_file, data)
  end

  # Reads the input file and returns an array of bytes. If the file does not
  # exist, an error is printed to the terminal and the program terminates.
  def self.get_file_bytes(file_name)
    if File.exist?(file_name)
      File.open(file_name, "rb") do |file|
        bytes = file.read.unpack("B*")
        return bytes[0].scan(/.{8}/)
      end
    else
      puts "Error: #{file_name} does not exist!"
      exit
    end
  end
end
