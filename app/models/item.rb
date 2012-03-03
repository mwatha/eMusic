class Item < ActiveRecord::Base
  set_table_name :item
  set_primary_key :item_id

  def self.get_items_for_display(type)
    case type
      when "mp3s"
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

  def self.get_album_songs(item_id)
    return [] if item_id.blank?
    Songs.find(:all,:conditions =>["item_id = ?",item_id])
  end

  def self.get_albums_by_genre_for_display(genre)
    item_ids = Songs.find(:all,:conditions =>["genre = ?",genre],
      :group => "item_id").collect{|s|s.item_id}

    display = {}
    records = Albums.find(:all,:select => "artist,description,
      image_url url,year,album_id , album_title",
      :joins =>"INNER JOIN item i ON i.item_id = albums.item_id",
      :conditions =>["albums.item_id IN(?)",item_ids])
    
    (records || []).each do |record|
      display[record.album_id] = {
        :artist => record.artist,:description => record.description,
        :url => record.url,:year => record.year,:title => record.album_title
      }
    end 
    return display
  end

end
