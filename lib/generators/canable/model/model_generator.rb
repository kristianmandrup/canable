module Canable::Generators
  class ModelGenerator < Rails::Generators::Base
    desc "Adds Canable::Ables permission system to Model" 

    argument :name, :type => :string, :required = true, :desc => 'Name of model to make Canable:Able'

    class_option :creatable,    :type => :boolean, :default => false,   :desc => 'Add creatable_by?(user) method'
    class_option :destroyable,  :type => :boolean, :default => false,   :desc => 'Add destroyable_by?(user) method'      
    class_option :updatable,    :type => :boolean, :default => false,   :desc => 'Add updatable_by?(user) method'
    class_option :viewable,     :type => :boolean, :default => false,   :desc => 'Add viewable_by?(user) method'
    class_option :userstamps,   :type => :boolean, :default => false,   :desc => 'Add user timestamps'      
          
    def self.source_root
      @source_root ||= File.expand_path("../../templates", __FILE__)
    end

    def make_canable_able
      model_file_txt  = File.open(model_file_name).read
      after_txt       = find_after_txt(model_file_txt)        

      inject_into_file(model_file_name, canable_include_txt, :after => after_txt) if after_txt
    end

    def post_log
      say "Your model #{model_class_name} has is now Canable:Able. Please define your permission login in #{model_file_name}", :green
    end

    protected

    def find_after_txt model_file_txt
      # after first include statement
      match = model_file_txt =~ /(include\s+\S+)/
      return $1 if match
      
      # or after class definition if no includes
      match = model_file_txt =~ /(class\s+#{model_class_name}\s+<\s+ActiveRecord::Base)/ # first try match AR model
      match = model_file_txt =~ /(class\s+#{model_class_name})/ if !match
      $1 || nil       
    end

    def model_class_name
      name.camelize
    end
                           
    def model_file_name
      "app/models/#{name}.rb"
    end
    
    def canable_include_txt
      %Q{
include Canable::Ables
#{add_userstamps}

# permission logic
#{add_methods}
}
    end

    def add_userstamps        
      "\n  userstamps! # adds creator and updater\n" if options[:userstamps]
    end

    def add_methods
      methods = []
      %w{creatable, destroyable, updatable, viewable}.each do |name|
        method = add_method(name)
        methods << method if method
      end
      methods.join("\n")
    end
    
    def add_method(name)        
      %Q{
def #{name}_by?(user)
  true
end
}     if options[name.to_sym]
    end      
  end 
end

      



