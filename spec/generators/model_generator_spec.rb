require 'rake'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require_generators :canable => ['model', 'user']

def account_content
%q{  class Account < Active::Record
  end}
end

def test_if_any_files
  files = FileList["#{::Rails.root}/**/*.rb"]
  puts "Files in Rails app: #{files}" 
end  

def create_model_file name
  file =  model_file_name(name)
  unless File.exist?(file)    
    FileUtils.mkdir_p File.dirname(file)
    File.open(file, 'w') do |f|  
      f.puts account_content
    end
  end
end  

def model_file_name name
  File.join(::Rails.root, "app/models/#{name}.rb")
end  

def remove_model_file name
  file = model_file_name(name)
  FileUtils.rm_f(file) if File.exist?(file)
end

describe 'Generator' do
  
  before :each do              
    remove_model_file 'account'    
  end
  
  GeneratorSpec.with_generator 'Generator' do |g, c, gc|
    gc.tests Canable::Generators::ModelGenerator
  end
    
  it "should not work without a User mode file" do            
    GeneratorSpec.with_generator do |g|   
      g.run_generator %w{account}
      g.should_not generate_file('app/models/account.rb')
    end
  end

  it "should not work without a User mode file" do            
    GeneratorSpec.with_generator do |g|             
      create_model_file 'account'      
      g.run_generator %w{account}                   
      g.should generate_file('app/models/account.rb') 
    end
  end
end



