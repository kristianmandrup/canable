require 'rake'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'generators/canable'
require 'helpers/model_helper'

describe 'model_generator' do
  
  before :each do              
    GeneratorSpec.setup_generator 'model_generator' do
      tests Canable::Generators::ModelGenerator
    end
    
    remove_model_file 'account'    
  end

  after :each do              
    remove_model_file 'account'    
  end
    
  it "should not work without an Account model file" do            
    GeneratorSpec.with_generator do |g|   
      name = 'account'
      g.run_generator %w{account}
      g.should_not generate_file("app/models/#{name}.rb")
    end
  end

  it "should decorate an existing Account model file with include Canable:Ables" do            
    GeneratorSpec.with_generator do |g|  
      name = 'account'
      create_model_file name     
      g.run_generator %w{account}
      g.should generate_file("app/models/#{name}.rb") do |content|
        content.should match /include Canable::Ables/
      end
    end
  end

  it "should decorate an Acount model file with include Canable:Ables and userstamps!" do            
    GeneratorSpec.with_generator do |g|  
      name = 'account'
      create_model_file name     
      g.run_generator %w{account --userstamps}                   
      g.should generate_file("app/models/#{name}.rb") do |content|
        content.should match /include Canable::Ables/
        content.should match /userstamps!/        
      end
    end
  end   
end



