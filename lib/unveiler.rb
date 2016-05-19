require_relative "unveiler/encoder"
require_relative "unveiler/decoder"

class Unveiler
  def self.encode(input_file, output_file, data)
    encoder = Encoder.new
    encoder.encode(input_file, output_file, data)
  end

  def self.decode(input_file, output_file)
    decoder = Decoder.new
    decoder.decode(input_file, output_file)
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

  # Writes the specified bytes to the output file by first converting the binary
  # to UTF-8 encoding.
  def self.write_bytes(bytes, file_name)
    puts "Writing #{file_name}"

    bytes.map!{|byte| byte = byte.to_i(2)}
    bytes = bytes.pack("C*").force_encoding("utf-8")

    File.open(file_name, "w"){|file| file.write(bytes)}
  end

  def self.write_file(data, file_name)
    puts "Writing #{file_name}"
    File.open(file_name, "w"){|file| file.write(data)}
  end
end
