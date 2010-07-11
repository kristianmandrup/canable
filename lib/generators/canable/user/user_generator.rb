module Canable::Generators
  class UserGenerator < Rails::Generators::Base
    desc "Adds Canable to User model" 

    argument :name, :default => 'user', :optional => true, :desc => 'Name of user model to make Canable'
          
    def self.source_root
      @source_root ||= File.expand_path("../../templates", __FILE__)
    end

    def make_canable
      user_file = File.open(model_file_name)
      user_file_txt = user_file.read
      match =~ /(class\s+#{model_class_name}\s+<\s+ActiveRecord::Base)/ # first try match AR model
      match =~ /(class\s+#{model_class_name})/ if !match
      after_txt = $1        
      if after_txt.present?
        inject_into_file(model_file_name, canable_include_txt, :after => after_txt)
      end
    end

    def post_log
      say %q{
        In your models insert the following:
        ------------------------------------
        class Article
      
          include Canable::Ables
          userstamps! # adds creator and updater

          # example permission logic
          # viewable_by?(user)   # all default to true
          # creatable_by?(user)
          # updatable_by?(user) 
          # destroyable_by?(user)
      
          def updatable_by?(user)
            creator == user
          end

          def destroyable_by?(user)
            updatable_by?(user)
          end                    
        end
      }
    end

    protected

    def model_class_name
      name.camelize
    end
                           
    def model_file_name
      "app/models/#{name}.rb"
    end
    
    def canable_include_txt
      "\ninclude Canable::Cans\n"
    end
  end 
end
      



