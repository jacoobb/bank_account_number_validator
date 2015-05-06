# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "bank_account_number_validator"
  gem.version       = '0.0.2'
  gem.authors       = ["jacoobb"]
  gem.email         = ["mikrut.jakub@gmail.com"]
  gem.summary       = %q{Bank account number validator}
  gem.description   = %q{Bank account number validator in your GemFile. }
  gem.homepage      = "https://github.com/jacoobb/bank_account_number_validator"
  gem.files         = `git ls-files`.split("\n")
  gem.executables   = ['bank_account_number_validator']
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]
  gem.license       = "MIT"
  gem.add_development_dependency "activemodel"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "nyan-cat-formatter"
end
