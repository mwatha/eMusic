class Order < ActiveRecord::Base
  set_table_name :orders
  set_primary_key :order_id

  def get_products
    music_category = ProductCategory.find_by_name("Audio CD album")                      
    video_category = ProductCategory.find_by_name("Video")                               
    gadget_category = ProductCategory.find_by_name("Gadget") 
    song_category = ProductCategory.find_by_name("Audio Song") 

    orders = ProductOrder.find_all_by_order_id(self.id)
    products = []
    orders.each do |order|
      product = Product.find(order.product_id)
      if product.product_category == music_category.id                                 
        album = Albums.find_by_product_id(order.product_id)                         
        products << [album.artist,album.album_title,order.quantity,order.price]                    
      elsif product.product_category == video_category.id                              
        video = Video.find_by_product_id(order.product_id)                          
        products << [video.title,video.category,order.quantity,order.price]                    
      elsif product.product_category == gadget_category.id                              
        gadget = Gadget.find_by_product_id(order.product_id)                          
        products << [gadget.name,gadget.version,order.quantity,order.price]                    
      elsif product.product_category == song_category.id                              
        song = Songs.find_by_product_id(order.product_id)                          
        products << [song.title,song.artist,song.album_title,order.price,self.id]                    
      end
    end
    products
  end

end
