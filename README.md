#Bank account number validator

In this version validations only POLISH bank account number.

## Installation
```ruby
gem install bank_account_number_validator
```
## Installation in GemFile
```ruby
gem 'bank_account_number_validator'
```
## Usage
```ruby
validates :number, bank_account_number: true
```