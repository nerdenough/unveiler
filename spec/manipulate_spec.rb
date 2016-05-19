require "unveiler"

RSpec.describe Unveiler, "#manipulate_bytes" do
  context "with equal number of bytes in string and array" do
    it "replaces the least significant bits with 0" do
      unveiler = Unveiler.new
      data = "0000"

      array = ["10001000", "10101010", "11111111", "11111111"]
      answer = ["10001000", "10101010", "11111110", "11111110"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it "replaces the least significant bits with 1" do
      unveiler = Unveiler.new
      data = "1111"

      array = ["10001000", "10101010", "11111111", "11111110"]
      answer = ["10001001", "10101011", "11111111", "11111111"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it "replaces the least significant bits with differing values" do
      unveiler = Unveiler.new
      data = "1010"

      array = ["10001000", "10101010", "11111111", "11111110"]
      answer = ["10001000", "10101011", "11111110", "11111111"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
  end

  context "with a larger array length than the data string" do
    it "replaces the least significant bits with 0" do
      unveiler = Unveiler.new
      data = "00"

      array = ["10001001", "10101011", "11111111", "11111111"]
      answer = ["10001001", "10101011", "11111110", "11111110"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it "replaces the least significant bits with 1" do
      unveiler = Unveiler.new
      data = "11"

      array = ["10001000", "10101010", "11111111", "11111111"]
      answer = ["10001000", "10101010", "11111111", "11111111"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it "replaces the least significant bits with differing values" do
      unveiler = Unveiler.new
      data = "10"

      array = ["10001001", "10101010", "11111111", "11111110"]
      answer = ["10001001", "10101010", "11111110", "11111111"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
  end

  context "with a longer data string than the array length" do
    it "replaces the least significant bits with 0" do
      unveiler = Unveiler.new
      data = "000000"

      array = ["11111111", "11111111", "11111111", "11111111"]
      answer = ["11111110", "11111110", "11111110", "11111110"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it "replaces the least significant bits with 1" do
      unveiler = Unveiler.new
      data = "111111"

      array = ["11111110", "11111110", "11111110", "11111110"]
      answer = ["11111111", "11111111", "11111111", "11111111"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
    it "replaces the least significant bits with differing values" do
      unveiler = Unveiler.new
      data = "100101"

      array = ["10001000", "10101011", "11111111", "11111110"]
      answer = ["10001001", "10101010", "11111110", "11111111"]
      result = unveiler.manipulate_bytes(array, data)

      expect(result.length).to eq 4
      expect(result).to eq answer
    end
  end
end
