require 'unveiler'

RSpec.describe Unveiler, '#manipulate_bytes' do
  context 'with equal number of bytes in string and array' do
    it 'replaces the least significant bits with 0' do
      data = '0000'

      array = ['10001000', '10101010', '11111111', '11111111']
      answer = ['10001000', '10101010', '11111110', '11111110']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it 'replaces the least significant bits with 1' do
      data = '1111'

      array = ['10001000', '10101010', '11111111', '11111110']
      answer = ['10001001', '10101011', '11111111', '11111111']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it 'replaces the least significant bits with differing values' do
      data = '1010'

      array = ['10001000', '10101010', '11111111', '11111110']
      answer = ['10001000', '10101011', '11111110', '11111111']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
  end

  context 'with a larger array length than the data string' do
    it 'replaces the least significant bits with 0' do
      data = '00'

      array = ['10001001', '10101011', '11111111', '11111111']
      answer = ['10001001', '10101011', '11111110', '11111110']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it 'replaces the least significant bits with 1' do
      data = '11'

      array = ['10001000', '10101010', '11111111', '11111111']
      answer = ['10001000', '10101010', '11111111', '11111111']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it 'replaces the least significant bits with differing values' do
      data = '10'

      array = ['10001001', '10101010', '11111111', '11111110']
      answer = ['10001001', '10101010', '11111110', '11111111']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
  end

  context 'with a longer data string than the array length' do
    it 'replaces the least significant bits with 0' do
      data = '000000'

      array = ['11111111', '11111111', '11111111', '11111111']
      answer = ['11111110', '11111110', '11111100', '11111100']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it 'replaces the least significant bits with 1' do
      data = '111111'

      array = ['11111110', '11111110', '11111110', '11111110']
      answer = ['11111111', '11111111', '11111111', '11111111']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it 'replaces the least significant bits with differing values' do
      data = '100101'

      array = ['10001000', '10101011', '11111111', '11111110']
      answer = ['10001001', '10101010', '11111110', '11111101']
      result = Unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it 'throws an error if the data is too large' do
      begin
        data = '0000000000000000'
        bytes = ['11111111']

        result = Unveiler.manipulate_bytes(bytes, data)
        fail
      rescue
        # Should fail
      end
    end
  end
end
