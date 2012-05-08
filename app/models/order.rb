class Order < ActiveRecord::Base
  set_table_name :orders
  set_primary_key :order_id

  def get_products
    music = ProductCategory.find_by_name("Audio CD album")                      
    video = ProductCategory.find_by_name("Video")                               
    #gadget = ProductCategory.find_by_name("Gadget") 

    orders = ProductOrder.find_all_by_order_id(self.id)
    products = []
    orders.each do |order|
      product = Product.find(order.product_id)
      if product.product_category == music.id                                 
        album = Albums.find_by_product_id(order.product_id)                         
        products << [album.artist,album.album_title,order.quantity,order.price]                    
      elsif product.product_category == video.id                              
        video = Video.find_by_product_id(order.product_id)                          
        products << [video.title,video.category,order.quantity,order.price]                    
      end
    end
    products
  end

end
