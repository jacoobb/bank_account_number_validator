class BankAccountNumberValidator::Validator
  
  def initialize location: nil, value: nil
    @validator = location_valid location, numbrt_only(value)
  end

  def valid
    @validator.valid
  end


  private

    def numbrt_only value
      value.chars.map{|char| char.to_i if char =~ /\d/}.compact
    end

    def location_valid location, value
      case location
      when :pl
        BankAccountNumberValidator::Validator::Pl.new value: value
      end
    end
end

require 'bank_account_number_validator/validator/pl'