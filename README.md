#Unveiler
[![Build Status](https://travis-ci.org/nerdenough/unveiler.svg?branch=master)](https://travis-ci.org/nerdenough/unveiler)
[![Gem Version](https://badge.fury.io/rb/unveiler.svg)](https://badge.fury.io/rb/unveiler)

Unveiler is a basic steganography tool for encoding strings within files. It
works by manipulating the bits of the input file, starting with the least
significant bits, replacing them with the next sequential bit of the data to
be encoded.

## Getting Started
### Installation
```
$ gem install unveiler
```

### Usage
```ruby
$ unveiler encode [input_file] [output_file] [data_to_encode]
$ unveiler decode [input_file] [output_file]
```

## In Depth
### Encoding a File
Files can be encoded using Unveiler's `encode` argument by specifying the input
and output file locations as well as providing the data to encode as a string.

```
$ unveiler encode file_to_encode.jpg output.jpg "Hello, world."
```

The above example will insert the string "Hello, world." into
`file_to_encode.jpg`, saving the encoded file as `output.jpg`.

### Decoding a File
Files can be decoded using Unveiler's `decode` argument by specifying the input
and output files. This will attempt to read the bits of the input file to
determine the encoded message. An error will be raised if an encoded string
cannot be found.

```
$ unveiler decode file_to_decode.jpg output_file.txt
```

The above example will take `file_to_decode.jpg`, decode the embedded string
and save as `output_file.txt`. If you had previously encoded "Hello, world."
into `file_to_decode.jpg`, you would expect "Hello, world." to be the contents
of `output_file.txt`.


## Running Tests
```
$ rspec --format doc
```
