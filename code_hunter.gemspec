# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "code_hunter/version"

Gem::Specification.new do |gem|
  gem.name          = "code_hunter"
  gem.version       = CodeHunter::VERSION
  gem.authors       = ["Ryo Nakamura"]
  gem.email         = ["r7kamura@gmail.com"]
  gem.description   = "Hunt out weak spots in your rails application"
  gem.summary       = "Code hunter"
  gem.homepage      = "https://github.com/r7kamura/code_hunter"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "nokogiri"
  gem.add_dependency "activesupport"
  gem.add_dependency "brakeman"
  gem.add_dependency "rails_best_practices"
  gem.add_dependency "pendaxes", "0.2.1"

  gem.add_development_dependency "rspec", ">= 2.12.0"
  gem.add_development_dependency "simplecov"
end
