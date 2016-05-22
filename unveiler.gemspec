Gem::Specification.new do |spec|
  spec.name = "unveiler"
  spec.version = "0.0.1"
  spec.date = "2016-05-22"
  spec.summary = "Encode hidden messages in files"
  spec.description = "Unveiler encodes hidden messages within files by manipulating their least significant bits."
  spec.authors = ["Brendan Goodenough"]
  spec.email = "brendan@goodenough.nz"
  spec.homepage = "https://github.com/nerdenough/unveiler"
  spec.files = ["lib/unveiler.rb"]
  spec.executables << "unveiler"
  spec.license = "MIT"
end
