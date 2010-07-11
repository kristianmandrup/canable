# require 'bundler'
# Bundler.setup(:default, :test)

require 'rspec'
require 'rspec/autorun'

require 'canable'
# gems

require 'matchers/all'
require 'generator_spec_helper'

RSpec.configure do |config|
  config.mock_with :mocha  
  config.include(RSpec::Rails::GeneratorMatchers)    
end
