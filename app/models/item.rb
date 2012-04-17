class Item < ActiveRecord::Base
  set_table_name :item
  set_primary_key :item_id

  def self.get_items_for_display(type)
    case type
      when "Audio albums"
        item_type = ItemType.find_by_name(type).id
        price_category_id = ProductPriceCategory.find_by_name("Audio CD album").id
        display = {}
        records = Albums.find(:all,:select => "artist,description,
          image_url url,year,album_id , album_title,price,quantity",
          :joins =>"INNER JOIN item i ON i.item_id = albums.item_id
          INNER JOIN product_prices p ON p.product_unique_id=albums.album_id
          AND p.product_category = #{price_category_id}",
          :conditions =>["item_type = ?",item_type])
        
        (records || []).each do |record|
          display[record.album_id] = {
            :artist => record.artist,:description => record.description,
            :url => record.url,:year => record.year,:title => record.album_title,
            :price => record.price,:quantity => record.quantity
          }
        end 
        return display
      when ""
    end
  end

  def self.get_album(album_id)
    display = []
    price_category_id = ProductPriceCategory.find_by_name("Audio CD album").id
    records = Albums.find(:all,:select => "artist,description,
      image_url url,year,album_id, i.item_id , album_title,price,quantity",
      :joins =>"INNER JOIN item i ON i.item_id = albums.item_id
      INNER JOIN product_prices p ON p.product_unique_id=albums.album_id
      AND p.product_category = #{price_category_id}",
      :conditions =>["album_id = ?",album_id])
    
    (records || []).each do |record|
      display << {
        :artist => record.artist,:description => record.description,:title => record.album_title,
        :url => record.url,:year => record.year ,:item_id => record.item_id,
        :album_id => record.album_id,:price => record.price,:quantity => record.quantity
      }
    end
    return display
  end

  def self.get_album_songs(album_id)
    return [] if album_id.blank?
    Songs.find(:all,:conditions =>["album_id = ?",album_id])
  end

  def self.get_albums_by_genre_for_display(genre)
    album_ids = Songs.find(:all,:conditions =>["genre = ?",genre],
      :group => "genre,album_id").collect{|s|s.album_id}

    display = {}
    price_category_id = ProductPriceCategory.find_by_name("Audio CD album").id
    records = Albums.find(:all,:select => "artist,description,
      image_url url,year,album_id , album_title,price,quantity",
      :joins =>"INNER JOIN item i ON i.item_id = albums.item_id
      INNER JOIN product_prices p ON p.product_unique_id=albums.album_id
      AND p.product_category = #{price_category_id}",
      :conditions =>["albums.album_id IN(?)",album_ids])
    
    (records || []).each do |record|
      display[record.album_id] = {
        :artist => record.artist,:description => record.description,
        :url => record.url,:year => record.year,:title => record.album_title,
        :album_id => record.album_id,:price => record.price,:quantity => record.quantity
      }
    end 
    return display
  end

  def self.add_album(params)
    img = Upload.img(params[:upload])
    item = self.new()
    item.item_type = ItemType.find_by_name("Audio albums").id
    item.description = params[:album]['description']
    item.image_url = "/images/artists/#{img}"
    item.save

    album = Albums.new()
    album.artist = params[:album]['artist'] 
    album.album_title = params[:album]['name']
    album.year = params[:album]['year']
    album.genre = params[:album]['genre']
    album.item_id = item.id
    album.save

    product_price = ProductPrice.new()
    product_price.product_unique_id = album.id
    product_price.product_category = ItemType.find_by_name("Audio albums").id
    product_price.price = params[:album]['price'].to_f
    product_price.quantity = params[:album]['quantity']
    product_price.save
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

  
end
