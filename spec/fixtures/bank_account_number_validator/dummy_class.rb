class DummyClass
  include ActiveModel::Validations
  
  attr_reader :number

  validates :number, bank_account_number: true

  def initialize number: nil
    @number = number
  end
end