
class Upload

  def self.save(upload)                                                         
    img_name =  upload['datafile'].original_filename                                
    image_file_extension = img_name[img_name.rindex(".") .. img_name.length].strip.chomp
    name = "#{Date.today.strftime('%d%m%y')}#{rand(10000)}#{image_file_extension}"
    directory = "#{RAILS_ROOT}/public/images/artists"                           
    # create the file path                                                      
    path = File.join(directory, name)                                           
    # write the file                                                            
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }              
  end 

end
