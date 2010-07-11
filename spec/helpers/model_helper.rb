def ar_file_content name
%Q{class #{name.camelize} < ActiveRecord::Base
end}
end

def rails_files
  files = FileList["#{::Rails.root}/**/*.rb"]
  puts "Files in Rails app: #{files}" 
end  

def create_model_file name
  file =  model_file_name(name)
  unless File.exist?(file)    
    FileUtils.mkdir_p File.dirname(file)
    File.open(file, 'w') do |f|  
      f.puts ar_file_content(name)
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

def remove_model_files *names
  names.each{|name| remove_model_file name }
end
