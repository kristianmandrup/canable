module RSpec  
  module Rails
    module Controller
      def create_controller name
        file =  controller_file_name(name)
        unless File.exist?(file)    
          FileUtils.mkdir_p File.dirname(file)
          File.open(file, 'w') do |f|  
            f.puts controller_content
          end
        end
      end  

      def helper_content name
        %Q{class #{name.camelize}Controller < ActionController::Base
        end}        
      end

      def remove_controller name
        file = helper_file_name(name)
        FileUtils.rm_f(file) if File.exist?(file)
      end

      def remove_controllers *names
        names.each{|name| remove_controller name }
      end
      
      protected
      
      def controller_file_name name
        File.join(::Rails.root, "app/controllers/#{name}.rb")
      end        
      
    end
  end
end