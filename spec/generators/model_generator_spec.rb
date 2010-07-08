require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Generator' do
  let(:generator) { Rails::Generators::Testcase.new }

  with generator do
    destination File.join(Rails.root)
    tests Canable::Generators::ModelGenerator
    setup :prepare_destination
    setup :copy_routes
  end
    
  it "should work"  
    generator.run_generator
    generator.should generate_file('app/models/hello.rb')            
  end
end



