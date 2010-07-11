require 'rake'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'generators/canable'
require 'helpers/rails_model'

describe 'model_generator' do
  include RSpec::Rails::Model
  include RSpec::Rails::Model::ActiveRecord
  
  before :each do              
    GeneratorSpec.setup_generator 'model_generator' do
      tests Canable::Generators::ModelGenerator
    end    
    remove_model 'account'    
  end

  after :each do              
    remove_model 'account'    
  end
    
  it "should not work without an Account model file" do            
    GeneratorSpec.with_generator do |g|   
      name = 'account'
      g.run_generator %w{account}
      g.should_not generate_file name, :model
    end
  end

  it "should decorate an existing Account model file with include Canable:Ables" do            
    GeneratorSpec.with_generator do |g|  
      name = 'account'
      create_model name     
      g.run_generator %w{account}
      g.should generate_file name, :model do |content|
        content.should have_class name.camelize do |klass|
          klass.should include_module 'Canable::Ables'
        end
      end
    end
  end

  it "should decorate an Acount model file with include Canable:Ables and userstamps!" do            
    GeneratorSpec.with_generator do |g|  
      name = 'account'
      create_model name     
      g.run_generator %w{account --userstamps}                   
      g.should generate_file name, :model do |content|
        content.should include_module 'Canable::Ables'
        content.should match /userstamps!/        
      end
    end
  end   
end



