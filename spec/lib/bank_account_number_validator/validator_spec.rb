require 'spec_helper'

describe BankAccountNumberValidator::Validator do
  before(:all) { @number = "83" }

  describe 'location_valid' do
    it "should call location_valid in initialize" do
      allow_any_instance_of(BankAccountNumberValidator::Validator).to receive(:remote_white_space).with(@number).and_return('123')

      expect_any_instance_of(BankAccountNumberValidator::Validator).to receive(:location_valid).with(:pl)
      BankAccountNumberValidator::Validator.new(location: :pl, value: @number )
    end

    it "should call PL validator" do
      allow_any_instance_of(BankAccountNumberValidator::Validator).to receive(:remote_white_space).with(@number).and_return('123')

      expect(BankAccountNumberValidator::Validator::Pl).to receive(:new).with(value: '123')
      BankAccountNumberValidator::Validator.new(location: :pl, value: @number)
    end
  end

  describe 'remote_white_space' do 
    before do 
      allow_any_instance_of(BankAccountNumberValidator::Validator).to receive(:location_valid).with(:pl).and_return(@valid_pl)
    end

    it do
      validator = BankAccountNumberValidator::Validator.new(location: :pl, value: @number)
      expect(validator.send(:remote_white_space, ' 12 23 23    23')).to eq('12232323')
    end
  end

  describe 'only_numer?' do

    before (:all) do
      ValidPL = Struct.new(:valid)
      @valid_pl = ValidPL.new(true)
    end

    before do
      allow_any_instance_of(BankAccountNumberValidator::Validator).to receive(:location_valid).with(:pl).and_return(@valid_pl)
    end

    it "return false" do
      allow_any_instance_of(BankAccountNumberValidator::Validator).to receive(:remote_white_space).with(@number).and_return('123a')
      validator = BankAccountNumberValidator::Validator.new(location: :pl, value: @number)
      expect(validator.valid).to be false
    end

    it "return true" do
      allow_any_instance_of(BankAccountNumberValidator::Validator).to receive(:remote_white_space).with(@number).and_return('123')
      validator = BankAccountNumberValidator::Validator.new(location: :pl, value: @number)
      expect(validator.valid).to be true
    end
  end
end