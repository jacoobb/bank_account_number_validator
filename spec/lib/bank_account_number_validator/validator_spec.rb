require 'spec_helper'

describe BankAccountNumberValidator::Validator do
  before(:all) { @number = "IBAN PL83 1010 1023 0000 2613 9510 0000" }

  describe 'numbrt_only' do 
    it "should return array" do
      validator = BankAccountNumberValidator::Validator.new(location: :pl, value: @number)
      expect(validator.send(:numbrt_only, @number)).to eq [8, 3, 1, 0, 1, 0, 1, 0, 2, 3, 0, 0, 0, 0, 2, 6, 1, 3, 9, 5, 1, 0, 0, 0, 0, 0]
    end
  end

  describe 'location_valid' do
    it "should call location_valid in initialize" do
      allow_any_instance_of(BankAccountNumberValidator::Validator).to receive(:numbrt_only).with(@number).and_return([1,2,3])

      expect_any_instance_of(BankAccountNumberValidator::Validator).to receive(:location_valid).with(:pl, [1,2,3])
      BankAccountNumberValidator::Validator.new(location: :pl, value: @number)
    end

    it "should call PL validator" do
      allow_any_instance_of(BankAccountNumberValidator::Validator).to receive(:numbrt_only).with(@number).and_return([1,2,3])

      expect(BankAccountNumberValidator::Validator::Pl).to receive(:new).with(value: [1,2,3])
      BankAccountNumberValidator::Validator.new(location: :pl, value: @number)
    end
  end
end