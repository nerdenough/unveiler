Gem::Specification.new do |spec|
  spec.name = "unveiler"
  spec.version = "0.0.2"
  spec.date = "2016-05-22"
  spec.summary = "A basic steganography tool for encoding strings within files"
  spec.description = "Unveiler is a basic steganography tool for encoding strings within files. It works by manipulating the bits of the input file, starting with the least significant bits, replacing them with the next sequential bit of the data to be encoded."
  spec.authors = ["Brendan Goodenough"]
  spec.email = "brendan@goodenough.nz"
  spec.homepage = "https://github.com/nerdenough/unveiler"
  spec.files = ["lib/unveiler.rb"]
  spec.required_ruby_version = '>=1.9.2'
  spec.executables << "unveiler"
  spec.license = "MIT"
end
