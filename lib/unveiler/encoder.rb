require "base64"

# Encoder holds methods used for encoding the given data into a specified
# image.
class Encoder
  # Encodes the specified data into the input file, saving the encode to the
  # specified output file location.
  def encode(input_file, output_file, data)
    data = Base64.encode64(data)
    data_lsb = data.unpack("B*").first

    input_file_lsb = get_input_file_bytes(input_file)
    replace_lsb(input_file_lsb, data_lsb)
    write_output_file(input_file_lsb, output_file)

    puts "Successfully encoded #{output_file}!"
  end

  def write_output_file(bytes, output_file)
    puts "Writing #{output_file}"

    bytes.map! do |byte|
      byte = byte.to_i(2)
    end

    bytes = bytes.pack("C*").force_encoding('utf-8')

    File.open(output_file, 'w') do |file|
      file.write(bytes)
    end
  end

  # Loops through the array of bytes from the input file, replacing the least
  # significant bit with the next sequential bit from the data array.
  def replace_lsb(input_file_lsb, data_lsb)
    puts "Encoding data"
    count = 0
    input_file_lsb.reverse.each do |byte|
      byte[7] = data_lsb[count]
      count += 1
      break if count == data_lsb.length
    end
  end

  # Reads the input file and returns an array of bytes. If the file does not
  # exist, an error is printed to the terminal and the program terminates.
  def get_input_file_bytes(input_file)
    if File.exist?(input_file)
      File.open(input_file, "rb") do |file|
        bytes = file.read.unpack("B*")
        return bytes[0].scan(/.{8}/)
      end
    else
      puts "Error: #{input_file} does not exist!"
      exit
    end
  end
end
