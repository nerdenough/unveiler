require 'unveiler'
require 'base64'

RSpec.describe Unveiler do
  before(:example) do
    @target = 'Hello, world!'
    @data = 'hi'
  end

  describe '#encode' do
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
      it 'should raise an error' do
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
end
