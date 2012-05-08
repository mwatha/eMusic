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

  def view
    music = ProductCategory.find_by_name("Audio CD album")                      
    video = ProductCategory.find_by_name("Video")                               
    #gadget = ProductCategory.find_by_name("Gadget")

    product = Product.find(params[:id])                                      
    if product.product_category == music.id
      @product_type = music.name
      @product = Product.get_album(params[:id])
      @songs = Product.get_album_songs(@product[0][:product_uniq_id]) 
    elsif product.product_category == video.id
      @product_type = video.name
      @product = Product.get_video(params[:id])
    end
    #render :layout => false
  end

  def add_to_cart
    case params[:id]
      when "album"
        quantity = params[:quantity].to_i
        product_id = params[:product_id].to_i
        if session[:cart].blank?
          session[:cart] = ["product_id:#{product_id}:quantity:#{quantity}"]
        end
        unless session[:cart].include?("product_id:#{product_id}:quantity#{quantity}")
          session[:cart] << "product_id:#{product_id}:quantity:#{quantity}"
        end
        roundedOrders = Hash.new(0)
        (session[:cart]).uniq.each do |cart|
          product_id = cart.split(':')[0..1].join(':')
          quantity = cart.split(':')[3].to_i
          roundedOrders[product_id]+= quantity
        end
        session[:cart] = []
        roundedOrders.each do |key , quantity|
          session[:cart] << "#{key}:quantity:#{quantity}"
        end
      when "video"
      when "pda"
    end
    session[:cart] = session[:cart].uniq
    redirect_to("/products/music")
  end

  def cart
  end
  
  def music_uploads   
    #raise params.to_yaml             
    Product.add_album(params)                                                   
    redirect_to("/users/settings")
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
    redirect_to("/users/settings")
  end

  def video_uploads   
    #raise params.to_yaml             
    Product.add_video(params)                                                   
    redirect_to("/users/settings")
  end 

end
