require 'rake'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'generators/canable_generators'
require 'helpers/rails_model'

describe 'user_generator' do
  include RSpec::Rails::Model
  include RSpec::Rails::Model::ActiveRecord
  
  before :each do
    GeneratorSpec.setup_generator 'user_generator' do
      tests Canable::Generators::UserGenerator
    end
  end
  
  after :each do              
    remove_models 'user', 'admin'
  end  
    
  it "should decorate User model file by default" do            
    GeneratorSpec.with_generator do |g|   
      name = 'user'
      create_model name      
      g.run_generator
      g.should generate_file name, :model do |content|
        content.should have_class name.camelize do |content|
          content.should include_module 'Canable::Cans'
        end
      end
    end
  end

  it "should decorate Admin user file if admin passed as firt argument" do            
    GeneratorSpec.with_generator do |g|  
      name = 'admin'
      create_model name
      g.run_generator %w{admin}                   
      g.should generate_file name, :model do |content|
        content.should have_class name.camelize do |content|
          content.should include_module 'Canable::Cans'
        end
      end
    end
  end
end



