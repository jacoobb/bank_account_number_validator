class BankAccountNumberValidator::Validator::Pl < BankAccountNumberValidator::Validator
  def initialize value: nil
    @value = value
    @weight = [1,10,3,30,9,90,27,76,81,34,49,5,50,15,53,45,62,38,89,17,73,51,25,56,75,71,31,19,93,57]
  end

  def valid
    return false unless length_valid
    set_pl_code
    set_first_to_end
    remainder?
  end

  
  private

    def length_valid
      @value.size == 26
    end

    def set_pl_code
      @value += [2, 5, 2, 1]
    end

    def set_first_to_end
      numbers = @value.slice!(0..1)
      @value += numbers
    end

    def remainder?
      sum_up_the_weight%97 == 1
    end

    def sum_up_the_weight
      result = 0
      @weight.each_with_index do |weight, index|
        result += weight * @value[@value.size - 1 - index]
      end
      result
    end
  
end