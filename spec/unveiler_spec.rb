require 'unveiler'
require 'base64'

RSpec.describe Unveiler do
  describe '#encode' do
    before(:example) do
      @target = 'Hello, world!'
      @data = 'hi'
    end

    context 'when the data is smaller than the target' do
      it 'should return the encoded data as a string' do
        result = Unveiler.encode(@target, @data)
        expect(result.is_a? String).to eq true
      end

      it 'should return a string of equal length to the target' do
        result = Unveiler.encode(@target, @data)
        expect(result.length).to eq @target.length
      end

      it 'should encode the data as base64 into the target' do
        result = Unveiler.encode(@target, @data)
        result = result.unpack('B*')[0].scan(/.{8}/)
        result = Unveiler.process_bytes(result)
        expect(Base64.decode64(result)).to eq @data
      end
    end

    context 'when the data is larger than the target' do
      it 'should raise a RuntimeError' do
        expect{Unveiler.encode(@data, @target)}.to raise_error(RuntimeError)
      end
    end

    context 'when the wrong arguments are passed' do
      it 'should raise an ArgumentError if the target is not a String' do
        expect{Unveiler.encode(true, @data)}.to raise_error(ArgumentError)
      end

      it 'should raise an ArgumentError if the data is not a String' do
        expect{Unveiler.encode(@target, [1, 2])}.to raise_error(ArgumentError)
      end
    end
  end

  describe '#decode' do
    before(:example) do
      @target = 'Hello, world!'
      @data = 'hi'
    end

    context 'when an encoded string is passed through' do
      it 'should return a decoded string' do
        encoded = Unveiler.encode(@target, @data)
        expect(Unveiler.decode(encoded)).to eq 'hi'
      end
    end

    context 'when the wrong arguments are passed' do
      it 'should raise an ArgumentError if the target is not a String' do
        expect{Unveiler.decode(true)}.to raise_error(ArgumentError)
      end
    end
  end

  describe '#manipulate_bytes' do
    before(:example) do
      @input_bytes = ['10001000', '10101010', '11111111', '00000000']
    end

    context 'when the data length matches the array size' do
      it 'should only replace the least significant bits' do
        data = '1111'
        ans = ['10001001', '10101011', '11111111', '00000001']
        result = Unveiler.manipulate_bytes(@input_bytes, data)
        expect(result).to eq ans
      end

      it 'should replace bits in reverse order' do
        data = '1010'
        ans = ['10001000', '10101011', '11111110', '00000001']
        result = Unveiler.manipulate_bytes(@input_bytes, data)
        expect(result).to eq ans
      end
    end

    context 'when the data length is twice the array size' do
      it 'should only replace the 2 least significant bits' do
        data = '11111111'
        ans = ['10001011', '10101011', '11111111', '00000011']
        result = Unveiler.manipulate_bytes(@input_bytes, data)
        expect(result).to eq ans
      end

      it 'should replace bits in reverse order' do
        data = '10101010'
        ans = ['10001000', '10101011', '11111100', '00000011']
        result = Unveiler.manipulate_bytes(@input_bytes, data)
        expect(result).to eq ans
      end
    end

    context 'when the data length is 8 times the array size' do
      it 'should replace every bit in the array' do
        data = '11111111111111111111111111111111'
        ans = ['11111111', '11111111', '11111111', '11111111']
        result = Unveiler.manipulate_bytes(@input_bytes, data)
        expect(result).to eq ans
      end

      it 'should replace bits in reverse order' do
        data = '10101010101010101010101010101010'
        ans = ['00000000', '11111111', '00000000', '11111111']
        result = Unveiler.manipulate_bytes(@input_bytes, data)
        expect(result).to eq ans
      end
    end

    context 'when the data length is larger than the array size' do
      it 'should raise a RuntimeError' do
        data = '111111111111111111111111111111111'
        expect{Unveiler.manipulate_bytes(@input_bytes, data)}.to raise_error(RuntimeError)
      end
    end
  end

  describe '#process_bytes' do
    before(:example) do
      @target = 'Hello, world!'
      @data = 'hi'
    end

    context 'when EOF is found' do
      it 'should return a decoded base64 string' do
        encoded = Unveiler.encode(@target, @data)
        bytes = encoded.unpack('B*')[0].scan(/.{8}/)
        decoded = Unveiler.process_bytes(bytes)
        expect(Base64.decode64(decoded)).to eq 'hi'
      end
    end

    context 'when no EOF can be decoded' do
      it 'should raise a RuntimeError' do
        bad_bytes = ['00000000']
        expect{Unveiler.process_bytes(bad_bytes)}.to raise_error(RuntimeError)
      end
    end
  end
end
