module RSpec::Rails
  module GeneratorMatchers
    class IncludeModule

      attr_reader :module_name

      def initialize module_name
        @module_name = module_name
      end

      def matches?(content)      
        @content = content        
        @content =~ /include #{module_name}/
        yield $2.strip if block_given?
      end          
    
      def failure_message
        "Expected there to be an inclusion of module #{module_name}"
      end 
      
      def negative_failure_message
        "Did not expect there to be an inclusion of module #{module_name}"
      end
                 
    end
    
    def include_module(module_name)
      IncludeModule.new(module_name)
    end    
  end  
end