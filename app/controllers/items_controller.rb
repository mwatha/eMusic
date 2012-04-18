class ItemsController < ApplicationController
  def music
    if params[:id]
      @artists = Item.get_albums_by_genre_for_display(params[:id])
    else
      @artists = Item.get_items_for_display("Audio albums")
    end
    
    render :layout => false
  end

  def dvd
  end

  def view
    @album = Item.get_album(params[:id])
    @songs = Item.get_album_songs(@album[0][:album_id]) 
    render :layout => false
  end

  def add_to_cart
    case params[:id]
      when "album"
        quantity = params[:quantity].to_i
        album_id = params[:album_id].to_i
        if session[:cart].blank?
          session[:cart] = ["album_id:#{album_id}:quantity:#{quantity}"]
        end
        unless session[:cart].include?("album_id:#{album_id}:quantity#{quantity}")
          session[:cart] << "album_id:#{album_id}:quantity:#{quantity}"
        end
        roundedOrders = Hash.new(0)
        (session[:cart]).uniq.each do |cart|
          album_id = cart.split(':')[0..1].join(':')
          quantity = cart.split(':')[3].to_i
          roundedOrders[album_id]+= quantity
        end
        session[:cart] = []
        roundedOrders.each do |key , quantity|
          session[:cart] << "#{key}:quantity:#{quantity}"
        end
      when "video"
      when "pda"
    end
    session[:cart] = session[:cart].uniq
    redirect_to("/items/music")
  end

  def cart
  end
  
  def music_uploads   
    #raise params.to_yaml             
    Item.add_album(params)                                                   
    redirect_to("/users/settings")
  end 

  def get_album_img
    album_id = params[:album_id]
    @album_attributes = Item.find(:first,
        :joins =>"INNER JOIN albums a ON a.item_id = item.item_id AND album_id = #{album_id}")

    render :text => "#{@album_attributes.description}::#{@album_attributes.image_url}"
    return
  end

  def add_mp3s
    Item.add_mp3s(params)
    redirect_to("/users/settings")
  end
end
