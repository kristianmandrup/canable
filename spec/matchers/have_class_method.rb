# This method manipulates the given path and tries to find any migration which
# matches the migration name. For example, the call above is converted to:
#
#   generator.should generate_migration "db/migrate/003_create_products.rb"
#
# Consequently it accepts the same arguments as the matcher have_file.

module RSpec::Rails
  module GeneratorMatchers
    class HaveClassMethod

      def initialize(content)
        begin
          @content = File.open(content).read
        rescue
          @content = content      
        end
      end

      # actual is the generator
      def matches?(method)      
        @method = method
        @content =~ /def\s+self.#{method}\s*(\(.+\))?(.*?)\n/m
      end          
    
      def failure_message
        "Expected there to be the class method #{method}, but there wasn't"
      end

      def negative_failure_message
        "Did not expect there to be the class method #{method}, but there was"
      end
            
    end

    def have_class_method(method)
      HaveClassMethod.new(method)
    end    
  end  
end


