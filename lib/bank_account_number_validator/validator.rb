class BankAccountNumberValidator::Validator
  
  def initialize location: nil, value: nil
    @value = remote_white_space value
    @validator = location_valid location
  end

  def valid
    return false unless only_numer?
    @validator.valid
  end


  private

    def only_numer?
      @value =~ /^(?<num>\d+)$/
    end

    def remote_white_space value
      value.gsub(/\s+/, "")
    end

    def location_valid location
      case location
      when :pl
        BankAccountNumberValidator::Validator::Pl.new value: @value
      end
    end
end

require 'bank_account_number_validator/validator/pl'