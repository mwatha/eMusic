
class Upload

  def self.img(upload)                                                         
    img_name =  upload['datafile'].original_filename                                
    image_file_extension = img_name[img_name.rindex(".") .. img_name.length].strip.chomp
    name = "#{Date.today.strftime('%d%m%y')}#{rand(10000)}#{image_file_extension}"
    directory = "#{RAILS_ROOT}/public/images/artists"                           
    # create the file path                                                      
    path = File.join(directory, name)                                           
    # write the file                                                            
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }              
    return name
  end 

  def self.song(upload,price,str,album,genre)                                                         
    song_name =  upload[str].original_filename rescue nil                            
    return false if song_name.blank?
    song_file_extension = song_name[song_name.rindex(".") .. song_name.length].strip.chomp
    name = "#{Date.today.strftime('%d%m%y')}#{rand(10000)}#{song_file_extension}"
    directory = "#{RAILS_ROOT}/public/songs"                           
    
    # create the file path                                                      
    path = File.join(directory, name)                                           
    # write the file                                                            
    File.open(path, "wb") { |f| f.write(upload[str].read) }              

    audio_length = Mp3Info.open("#{directory}/#{name}")

    song = Songs.new()
    song.album_id = album.id
    song.title = audio_length.tag['title'].humanize
    song.time = (audio_length.length/60).to_f.round(2)
    song.track_number = audio_length.tag['tracknum']
    song.genre = genre
    song.year = audio_length.tag['year'] || album.year
    song.url = "#{directory}/#{name}"
    song.save

    product_price = ProductPrice.new()
    product_price.product_unique_id = song.id
    product_price.product_category = ProductPriceCategory.find_by_name('Audio song').id
    product_price.price = price
    product_price.quantity = 1
    return product_price.save
  end 

end
