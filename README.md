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
#### Encode with a file
The following example will encode the text from helloworld.txt into the input
file, saving it to the output file.
```
$ unveiler -e -i input -o output -f helloworld.txt
```

#### Encode with a string
The following example will encode the string "Hello, world" into the input
file, saving it to the output file.
```
$ unveiler -e -i input -o output -s "Hello, world"
```

#### Decode
The following example will decode the input file, writing any decoded string
into the output file.
```
$ unveiler -d -i encoded -o decoded
```

## In Depth
### Arguments
Short|Long|Description
---|---|---
-e|--encode|Runs the encode operation
-d|--decode|Runs the decode operation
-i|--input|Specifies the input file
-o|--output|Specifies the output file
-s|--string|Specifies the data as a string
-f|--file|Specifies the data as a file to read

### Encode
When running the encode method, you must always specify an input file, output
file and either a string or file to encode.

### Decode
When running the decode method, you must always specifiy the input and output
files.

## Running Tests
```
$ rspec --format doc
```
