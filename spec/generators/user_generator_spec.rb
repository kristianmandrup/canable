require 'rake'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'generators/canable_generators'
require 'helpers/model_helper'

describe 'user_generator' do    

  before :each do
    GeneratorSpec.setup_generator 'user_generator' do
      tests Canable::Generators::UserGenerator
    end
  end
  
  after :each do              
    remove_model_files 'user', 'admin'
  end  
    
  it "should not work without a User mode file" do            
    GeneratorSpec.with_generator do |g|   
      create_model_file 'user'      
      g.run_generator
      g.should generate_file('app/models/user.rb')
    end
  end

  it "should work with a User model file" do            
    GeneratorSpec.with_generator do |g|
      create_model_file 'admin'      
      g.run_generator %w{admin}                   
      g.should generate_file('app/models/admin.rb') do |content|
        content.should match /include Canable::Cans/
      end
    end
  end
end



