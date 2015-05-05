require 'spec_helper'
require_relative '../fixtures/bank_account_number_validator/dummy_class.rb'

describe BankAccountNumberValidator do
  
  describe "valid is false" do

    it "number is incorrect" do
      dummy_class = DummyClass.new number: 'PL1234567890123456789012345444444535353453'
      expect(dummy_class.valid?).to be false 
    end

    it "should return errors" do
      dummy_class = DummyClass.new number: 'IBAN PL83 1010 1023 0000 2613 9510 0001'
      dummy_class.valid?
      expect(dummy_class.errors[:number]).to_not be_empty
    end
  end

  describe "valid is true" do

    it "number is correct" do
      dummy_class = DummyClass.new number: 'IBAN PL83 1010 1023 0000 2613 9510 0000'
      expect(dummy_class.valid?).to be true 
    end

    it "should not return errors" do
      dummy_class = DummyClass.new number: 'IBAN PL83 1010 1023 0000 2613 9510 0000'
      dummy_class.valid?
      expect(dummy_class.errors[:number]).to be_empty
    end

  end
end