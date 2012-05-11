class ProductsController < ApplicationController
  def music
    if params[:id]
      @artists = Product.get_albums_by_genre_for_display(params[:id])
    else
      @artists = Product.get_products_for_display("Audio CD album")
    end
    
    #render :layout => false
  end

  def dvd
    if params[:id]
      @artists = Product.get_video_by_category_for_display(params[:id])
    else
      @artists = Product.get_products_for_display("Video")
    end
  end

  def electronics
    if params[:id]
      @electronics = Product.get_gadget_by_brand_name_for_display(params[:id])
    else
      @electronics = Product.get_products_for_display("Gadget")
    end
  end

  def view
    music = ProductCategory.find_by_name("Audio CD album")                      
    video = ProductCategory.find_by_name("Video")                               
    gadget = ProductCategory.find_by_name("Gadget")

    product = Product.find(params[:id])                                      
    if product.product_category == music.id
      @product_type = music.name
      @product = Product.get_album(params[:id])
      @songs = Product.get_album_songs(@product[0][:product_uniq_id]) 
    elsif product.product_category == video.id
      @product_type = video.name
      @product = Product.get_video(params[:id])
    elsif product.product_category == gadget.id
      @product_type = gadget.name
      @product = Product.get_gadget(params[:id])
    end
    #render :layout => false
  end

  def cart
  end
  
  def music_uploads   
    #raise params.to_yaml             
    Product.add_album(params)                                                   
    redirect_to("/products/music")
  end 

  def get_album_img
    album_id = params[:album_id]
    @album_attributes = Product.find(:first,
        :joins =>"INNER JOIN albums a ON a.product_id = product.product_id AND album_id = #{album_id}")

    render :text => "#{@album_attributes.description}::#{@album_attributes.image_url}"
    return
  end

  def add_mp3s
    Product.add_mp3s(params)
    redirect_to("/products/music")
  end

  def video_uploads   
    #raise params.to_yaml             
    Product.add_video(params)                                                   
    redirect_to("/products/dvd")
  end 

  def gadget_uploads   
    #raise params.to_yaml             
    Product.add_gadget(params)                                                   
    redirect_to("/products/electronics")
  end 

end
