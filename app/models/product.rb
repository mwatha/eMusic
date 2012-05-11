class Product < ActiveRecord::Base
  set_table_name :product
  set_primary_key :product_id

  def self.get_products_for_display(type)
    case type
      when "Audio CD album"
        category_id = ProductCategory.find_by_name(type).id
        display = {}
        records = Albums.find(:all,:select => "artist,description,
          image_url url,year, p.product_id , album_title,price,quantity",
          :joins =>"INNER JOIN product p ON p.product_id = albums.product_id
          AND p.product_category = #{category_id}")
       
        (records || []).each do |record|
          display[record.product_id] = {
            :artist => record.artist,:description => record.description,
            :url => record.url,:year => record.year,:title => record.album_title,
            :price => record.price,:quantity => record.quantity
          }
        end 
        return display
      when "Video"
        category_id = ProductCategory.find_by_name(type).id
        display = {}
        records = Video.find(:all,:select => "title,description,
          image_url url,year, p.product_id , category,price,quantity",
          :joins =>"INNER JOIN product p ON p.product_id = video.product_id
          AND p.product_category = #{category_id}")
       
        (records || []).each do |record|
          display[record.product_id] = {
            :title => record.title,:description => record.description,
            :url => record.url,:year => record.year,:category => record.category,
            :price => record.price,:quantity => record.quantity
          }
        end 
        return display
      when "Gadget"
        category_id = ProductCategory.find_by_name(type).id
        display = {}
        records = Gadget.find(:all,:select => "name,description,
          image_url url,year, p.product_id , version,price,quantity",
          :joins =>"INNER JOIN product p ON p.product_id = gadget.product_id
          AND p.product_category = #{category_id}")
       
        (records || []).each do |record|
          display[record.product_id] = {
            :name => record.name,:description => record.description,
            :url => record.url,:year => record.year,:version => record.version,
            :price => record.price,:quantity => record.quantity
          }
        end 
        return display
    end
  end

  def self.get_album(product_id)
    display = []
    category_id = ProductCategory.find_by_name("Audio CD album").id
    records = Albums.find(:all,:select => "artist,description,
      image_url url,year,album_id, p.product_id , album_title,price,quantity",
      :joins =>"INNER JOIN product p ON p.product_id = albums.product_id
      AND p.product_category = #{category_id}",
      :conditions =>["albums.product_id = ?",product_id])
    
    (records || []).each do |record|
      display << {
        :product => record.artist,:description => record.description,:title => record.album_title,
        :url => record.url,:year => record.year ,:product_id => record.product_id,
        :product_uniq_id => record.album_id,:price => record.price,:quantity => record.quantity
      }
    end
    return display
  end

  def self.get_video(product_id)
    display = []
    category_id = ProductCategory.find_by_name("Video").id
    records = Video.find(:all,:select => "title,description,
      image_url url,year,video_id, p.product_id ,category,price,quantity",
      :joins =>"INNER JOIN product p ON p.product_id = video.product_id
      AND p.product_category = #{category_id}",
      :conditions =>["video.product_id = ?",product_id])
    
    (records || []).each do |record|
      display << {
        :product => record.title,:description => record.description,:title => record.category,
        :url => record.url,:year => record.year ,:product_id => record.product_id,
        :product_uniq_id => record.video_id,:price => record.price,:quantity => record.quantity
      }
    end
    return display
  end

  def self.get_gadget(product_id)
    display = []
    category_id = ProductCategory.find_by_name("Gadget").id
    records = Gadget.find(:all,:select => "name,description,
      image_url url,year,gadget_id, p.product_id ,version,price,quantity",
      :joins =>"INNER JOIN product p ON p.product_id = gadget.product_id
      AND p.product_category = #{category_id}",
      :conditions =>["gadget.product_id = ?",product_id])
    
    (records || []).each do |record|
      display << {
        :product => record.name,:description => record.description,:title => record.version,
        :url => record.url,:year => record.year ,:product_id => record.product_id,
        :product_uniq_id => record.gadget_id,:price => record.price,:quantity => record.quantity
      }
    end
    return display
  end

  def self.get_album_songs(album_id)
    return [] if album_id.blank?
    product_category = ProductCategory.find_by_name("Audio Song").id
    records = Songs.find(:all,:joins =>"INNER JOIN albums a ON a.album_id = songs.album_id
      INNER JOIN product p ON p.product_id = songs.product_id
      AND product_category = #{product_category}",
      :select => "song_id,title,time,price,track_number,songs.product_id",
      :conditions =>["a.album_id = ?",album_id],:order => "track_number")
    
    display = {}
    (records || []).each do |record|
      display[record.song_id] = {
        :price => record.price,:title => record.title,:product_id => record.product_id,
        :time => record.time,:track_number => record.track_number
      }
    end 
    display 
  end

  def self.get_albums_by_genre_for_display(genre)
    category_id = ProductCategory.find_by_name("Audio CD album").id
    records = Albums.find(:all,
      :select => "artist,description,
      image_url url, year , p.product_id product_id ,album_title , p.price , p.quantity",
      :joins =>"INNER JOIN product p ON p.product_id = albums.product_id
      AND p.product_category = #{category_id}",
      :conditions =>["genre = ?",genre],
      :group => "genre,album_id")

    display = {}
    
    (records || []).each do |record|
      display[record.product_id] = {
        :artist => record.artist,:description => record.description,
        :url => record.url,:year => record.year,:title => record.album_title,
        :album_id => record.album_id,:price => record.price,:quantity => record.quantity
      }
    end 
    return display
  end

  def self.add_album(params)
    img = Upload.img(params[:upload])
    product = self.new()
    product.product_category = ProductCategory.find_by_name("Audio CD album").id
    product.description = params[:album]['description']
    product.image_url = "/images/artists/#{img}"
    product.price = params[:album]['price'].to_f
    product.quantity = params[:album]['quantity']
    product.date_created = Time.now()
    product.save

    album = Albums.new()
    album.artist = params[:album]['artist'] 
    album.album_title = params[:album]['name']
    album.year = params[:album]['year']
    album.genre = params[:album]['genre']
    album.product_id = product.id
    album.save

  end

  def self.add_mp3s(params)
    number_songs_uploading =  params['number_uploaded'].to_i
    album = Albums.find(params["album_id"])


    (1.upto(number_songs_uploading)).each do | number |
      str = "datafile#{number}"
      price = params["price_#{number}"].to_f rescue nil
      
      uploaded = Upload.song(params[:upload],price,str,album)
    end

  end

  def self.add_video(params)
    img = Upload.img(params[:upload])
    product = self.new()
    product.product_category = ProductCategory.find_by_name("Video").id
    product.description = params[:video]['description']
    product.image_url = "/images/artists/#{img}"
    product.price = params[:video]['price'].to_f
    product.quantity = params[:video]['quantity']
    product.date_created = Time.now()
    product.save

    video = Video.new()
    video.title = params[:video]['title'] 
    video.category = params[:video]['category']
    video.year = params[:video]['year']
    video.length = params[:video]['length']
    video.product_id = product.id
    video.date_created = Time.now()
    video.save

  end
  
  def self.add_gadget(params)
    img = Upload.img(params[:upload])
    product = self.new()
    product.product_category = ProductCategory.find_by_name("Gadget").id
    product.description = params[:gadget]['description']
    product.image_url = "/images/artists/#{img}"
    product.price = params[:gadget]['price'].to_f
    product.quantity = params[:gadget]['quantity']
    product.date_created = Time.now()
    product.save

    gadget = Gadget.new()
    gadget.name = params[:gadget]['name'] 
    gadget.brand_name = params[:gadget]['brand']
    gadget.year = params[:gadget]['year']
    gadget.version = params[:gadget]['version']
    gadget.product_id = product.id
    gadget.date_created = Time.now()
    gadget.save

  end
  
  def self.get_video_by_category_for_display(category)
    category_id = ProductCategory.find_by_name("Video").id
    records = Video.find(:all,
      :select => "title,description,
      image_url url, year , p.product_id product_id ,category , p.price , p.quantity",
      :joins =>"INNER JOIN product p ON p.product_id = video.product_id
      AND p.product_category = #{category_id}",
      :conditions =>["category = ?",category],
      :group => "category,video_id")

    display = {}
    
    (records || []).each do |record|
      display[record.product_id] = {
        :title => record.title,:description => record.description,
        :url => record.url,:year => record.year,:category => record.category,
        :price => record.price,:quantity => record.quantity
      }
    end 
    return display
  end

  def self.get_gadget_by_brand_name_for_display(brand)
    category_id = ProductCategory.find_by_name("Gadget").id
    records = Gadget.find(:all,
      :select => "name,description,
      image_url url, year , p.product_id product_id ,brand_name , version ,
      p.price , p.quantity",
      :joins =>"INNER JOIN product p ON p.product_id = gadget.product_id
      AND p.product_category = #{category_id}",
      :conditions =>["brand_name = ?",brand],
      :group => "brand_name,gadget_id")

    display = {}
    
    (records || []).each do |record|
      display[record.product_id] = {
        :name => record.name,:description => record.description,
        :url => record.url,:year => record.year,:version => record.version,
        :price => record.price,:quantity => record.quantity
      }
    end 
    return display
  end
end
