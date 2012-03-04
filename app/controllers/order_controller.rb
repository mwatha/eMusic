class OrderController < ApplicationController
  def view
    @orders = []
    (session[:cart] || []).each do |cart|
      type = cart.split(":")[0]                                                 
      if type.match(/album_id/i)                                                
        album_id = cart.split(":")[1]                                           
        quantity = cart.split(":")[3].to_i                                          
        album = Albums.find(album_id)                                           
        album_price = ProductPrice.find_by_product_unique_id(album.id).price                  
        @orders << [album.artist,album.album_title,album_price,quantity,(quantity * album_price).to_f]
      end                                                                       
    end
  end

end
