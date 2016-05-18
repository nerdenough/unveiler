require_relative "encoder/encoder"

def encode(input_file, output_file, data)
  encoder = Encoder.new
  encoder.encode(input_file, output_file, data)
end

if ARGV.empty?
  puts "Error: Missing Arguments"
  exit
elsif ARGV.first == "encode"
  if ARGV.length == 4
    input_file = ARGV[1]
    output_file = ARGV[2]
    data = ARGV[3]
    encode(input_file, output_file, data)
  else
    puts "Unveiler: Expected 'uv encode [input_file] [output_file] [data]'"
  end
else
  puts "Unveiler: Invalid command #{ARGV.first}"
end
