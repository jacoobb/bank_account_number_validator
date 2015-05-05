require 'spec_helper'

describe BankAccountNumberValidator::Validator::Pl do

  describe "length_valid" do

    it "return false if number is blank" do
      validator = BankAccountNumberValidator::Validator::Pl.new value: ''
      expect(validator.valid).to be false 
    end

    it "return false if number is too short" do
      validator = BankAccountNumberValidator::Validator::Pl.new value: [1,2,3]
      expect(validator.valid).to be false 
    end

    it "return false if number is too long" do
      validator = BankAccountNumberValidator::Validator::Pl.new value: (1..40).to_a
      expect(validator.valid).to be false 
    end

    it 'call length_valid' do
      expect_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:length_valid)
      validator = BankAccountNumberValidator::Validator::Pl.new value: [1,2,3]
      validator.valid
    end

  end

  describe "set_pl_code" do
    it "add code to array" do
      validator = BankAccountNumberValidator::Validator::Pl.new value: [1,2,3]
      expect(validator.send(:set_pl_code)).to eq [1,2,3,2,5,2,1]
    end 

    it "call set_pl_code" do
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:length_valid).and_return true
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:set_first_to_end)
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:remainder?)

      expect_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:set_pl_code)
      validator = BankAccountNumberValidator::Validator::Pl.new value: [1,2,3]
      validator.valid
    end
  end

  describe "set_first_to_end" do
    it "set first to end" do
      validator = BankAccountNumberValidator::Validator::Pl.new value: [1,2,3]
      expect(validator.send(:set_first_to_end)).to eq [3,1,2]
    end 

    it "call set_pl_code" do
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:length_valid).and_return true
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:set_pl_code)
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:remainder?)

      expect_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:set_first_to_end)
      validator = BankAccountNumberValidator::Validator::Pl.new value: [1,2,3]
      validator.valid
    end
  end

  describe "sum_up_the_weight" do
    it "set first to end" do
      validator = BankAccountNumberValidator::Validator::Pl.new value: [8,3,1,0,1,0,1,0,2,3,0,0,0,0,2,6,1,3,9,5,1,0,0,0,0,0]
      expect(validator.send(:sum_up_the_weight)).to eq 2669
    end 

    it "call sum_up_the_weight" do
      expect_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:sum_up_the_weight).and_return 97

      validator = BankAccountNumberValidator::Validator::Pl.new value: [1,2,3]
      validator.send :remainder?
    end
  end

  describe 'remainder?' do
    it "return true " do
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:sum_up_the_weight).and_return 98
      validator = BankAccountNumberValidator::Validator::Pl.new value: [8,3]
      expect(validator.send(:remainder?)).to be true
    end

    it "return false" do
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:sum_up_the_weight).and_return 97
      validator = BankAccountNumberValidator::Validator::Pl.new value: [8,3]
      expect(validator.send(:remainder?)).to be false
    end

    it "call set_pl_code" do
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:length_valid).and_return true
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:set_pl_code)
      allow_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:set_first_to_end)

      expect_any_instance_of(BankAccountNumberValidator::Validator::Pl).to receive(:remainder?)
      validator = BankAccountNumberValidator::Validator::Pl.new value: [1,2,3]
      validator.valid
    end
  end
end