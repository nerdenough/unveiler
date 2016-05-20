require 'unveiler'

RSpec.describe Unveiler do
  before(:example) do
    @input_bytes = ['10001000', '10101010', '11111111', '00000000']
  end

  describe '#manipulate_bytes' do
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
      it 'should raise an error' do
        begin
          data = '111111111111111111111111111111111'
          Unveiler.manipulate_bytes(@input_bytes, data)
          fail
        rescue
          # Should have raised an error
        end
      end
    end
  end
end
