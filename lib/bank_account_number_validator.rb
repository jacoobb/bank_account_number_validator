require 'active_model'

class BankAccountNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless BankAccountNumberValidator::Validator.new(location: :pl, value: value).valid
      record.errors[attribute] << (options[:message] || "wrong format")
    end
  end
end