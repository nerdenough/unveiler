require "base64"

# Encoder holds methods used for encoding the given data into a specified
# image.
class Encoder
  # Encodes the specified data into the input file, saving the encode to the
  # specified output file location.
  def encode(input_file, output_file, data)
    data = Base64.encode64(data)
    data = data.unpack("B*").first

    bytes = get_input_file_bytes(input_file)
    replace_bytes(bytes, data)
    write_output_file(bytes, output_file)

    puts "Successfully encoded #{output_file}!"
  end

  # Writes the specified bytes to the output file by first converting the binary
  # to UTF-8 encoding.
  def write_output_file(bytes, output_file)
    puts "Writing #{output_file}"

    bytes.map!{|byte| byte = byte.to_i(2)}
    bytes = bytes.pack("C*").force_encoding('utf-8')

    File.open(output_file, 'w'){|file| file.write(bytes)}
  end

  # Loops through the specified bytes array, replacing the least significant
  # bits with the following bit from the data. The loop is terminated when
  # either all bytes in the array have been iterated over, or the end of the
  # data string has been reached.
  def replace_bytes(bytes, data)
    count = 0
    bytes.reverse.each do |byte|
      byte[7] = data[count]
      count += 1
      break if count == data.length
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
