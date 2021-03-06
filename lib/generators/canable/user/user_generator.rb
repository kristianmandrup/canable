module Canable::Generators
  class UserGenerator < Rails::Generators::Base
    desc "Adds Canable to User model" 

    argument :name, :default => 'user', :optional => true, :desc => 'Name of user model to make Canable'
          
    def self.source_root
      @source_root ||= File.expand_path("../../templates", __FILE__)
    end

    def make_canable
      if File.exist?(model_file_name)
        @user_file_txt = File.open(model_file_name).read
        match = (user_file_txt =~ /(<\s+ActiveRecord::Base)/) # first try match AR model
        if !match
          match = (user_file_txt =~ /(class\s+#{model_class_name})/) 
        end        
        after_txt = $1        
        if after_txt.present?
          if !canable?          
            inject_into_file(model_file_name, canable_include_txt, :after => after_txt)
            say "The user model #{name} is now Canable", :green
          else
            say "The user model #{name} was already Canable", :yellow            
          end
        end
      else
        say "The model file #{name} does not exist, so it can't be decorated with Canable", :red
      end
    end

    protected

    attr_accessor :user_file_txt

    def canable?
      user_file_txt =~ /include Canable::Cans/
    end

    def model_class_name
      name.camelize
    end
                           
    def model_file_name
      File.join(Rails.root, "app/models/#{name}.rb")
    end
    
    def canable_include_txt
      "\n  include Canable::Cans\n"
    end
  end 
end
      



