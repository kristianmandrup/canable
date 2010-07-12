module RSpec::Rails
  module GeneratorMatchers
    class InheritFrom

      attr_reader :klass

      def initialize(content)
        @klass = klass
      end

      def matches?(content)      
        @content = content
        @content =~ /class\s+(.*?)<\s+#{klass}(.*)end/
        yield $2.strip if block_given?
      end          
    
      def failure_message
        "Expected the class to inherit from #{klass}"
      end 
      
      def negative_failure_message
        "Did not expect the class to inherit from #{klass}"
      end
    end
    
    def inherit_from(klass)
      InheritFrom.new(klass)
    end    
  end  
end