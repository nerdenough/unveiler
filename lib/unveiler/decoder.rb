require "base64"

class Decoder
  def decode(input_file, output_file)
    bytes = Unveiler.get_file_bytes(input_file)
    data = process(bytes)

    data.map!{|byte| byte = byte.to_i(2)}
    data = data.pack("C*").force_encoding("utf-8")
    data = Base64.decode64(data)
    Unveiler.write_file(data + "\n", output_file)
  end
  
  def process(bytes)
    bits = ""
    bytes.reverse.each do |byte|
      bits += byte[7]
      if bits.length % 8 == 0
        arr = bits.scan(/.{8}/)
        if arr.length >= 3
          arr.map!{|byte| byte = byte.to_i(2)}
          arr = arr.pack("C*").force_encoding("utf-8")
          len = arr.length
          if arr[len - 3] == "E" && arr[len - 2] == "O" && arr[len - 1] == "F"
            length = bits.length
            return bits[0..length - 24].scan(/.{8}/)
          end
        end
      end
    end
    return bits.scan(/.{8}/)
  end
end
