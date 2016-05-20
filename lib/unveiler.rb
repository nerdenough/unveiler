require 'base64'

# Unveiler is a basic steganography tool that encodes data by manipulating
# existing binary data and can decode previously encoded data.
#
# Author::      Brendan Goodenough
# Copyright::   Copyright (c) 2016 Brendan Goodenough
# License::     MIT
#
# The encoding of the data is achieved by manipulating the least significant
# bits of each byte in the target data. These bits are replaced with the next
# sequential bit of the data to be encoded, looping until the end of the data
# is reached.
#
# Decoding is achieved by looping through each byte of the target data, and
# stringing together the least significant bits of each byte. This is repeated
# until the last 3 bytes in the string of bits forms the phrase 'EOF'.

class Unveiler
  # Encodes the specified string of data into the target data. Upon success,
  # a UTF-8 string containing the manipulated data will be returned.
  #
  # +target+::  Target data to be manipulated
  # +data+::    Data to encode
  def self.encode(target, data)
    # Convert target data into an array of bytes
    bytes = target.unpack('B*')[0].scan(/.{8}/)

    # Convert data to binary
    data = Base64.encode64(data)
    data += 'EOF'
    data = data.unpack('B*').first

    # Encode the data into the array of bytes
    bytes = self.manipulate_bytes(bytes, data)

    # Convert binary to UTF-8
    bytes.map!{|byte| byte = byte.to_i(2)}
    return bytes.pack('C*').force_encoding('utf-8')
  end

  # Decodes any data within the specified target data. Upon success, the decoded
  # string will be returned.
  #
  # +target+::  Target data to be decoded
  def self.decode(target)
    # Convert the target data into an array of bytes
    bytes = target.unpack('B*')[0].scan(/.{8}/)

    # Obtain string from the bytes
    bytes = self.process_bytes(bytes)
    return Base64.decode64(bytes)
  end

  # Manipulates an array of bytes by looping through and replacing the least
  # significant bit of each byte with the next sequential bit in a string of
  # binary data. The loop will break when the end of the data string is
  # reached. Returns the manipulated array of bytes.
  #
  # +bytes+:: Array of bytes to manipulate
  # +data+::  Binary data to insert
  def self.manipulate_bytes(bytes, data)
    count = 0

    8.times do |index|
      # Loop through each byte and replace the bit at the given index
      bytes.reverse.each do |byte|
        byte[7 - index] = data[count]
        count += 1
        return bytes if count == data.length
      end
    end

    # Ran out of space to encode data
    raise 'Input file is too small for the specified data'
  end

  # Processes the specified array of bytes by looping through each byte and
  # appending the least significant bit onto a string of bits. At the end of
  # every eighth bit, a check will be made to see if the last 3 bytes of the
  # string contain the phrase 'EOF'. Only the bytes before EOF will be returned
  # if the phrase is found. An error will be raised if no EOF is found.
  #
  # +bytes+:: Array of bytes to be processed
  def self.process_bytes(bytes)
    bits = ''

    8.times do |index|
      bytes.reverse.each do |byte|
        # Least significant bit
        bits += byte[7 - index]

        # Check whether a full byte has been read
        if bits.length % 8 == 0
          # Convert bits to array of bytes
          data = bits.scan(/.{8}/)

          if data.length >= 3
            # Convert bytes to a UTF-8 string
            data.map!{|byte| byte = byte.to_i(2)}
            data = data.pack('C*').force_encoding('utf-8')
            len = data.length

            if data[-3,3] == 'EOF'
              # Return the UTF-8 string, excluding 'EOF'
              return data[0..len - 3]
            end
          end
        end
      end
    end

    # No EOF was found, error
    raise 'No phrase matching "EOF" was found'
  end
end
