class ItemsController < ApplicationController
  def music
    case params[:id]
      when "Rock"
        @artists = Item.get_albums_by_genre_for_display(params[:id])
      when "Hip Hop"
        @artists = Item.get_albums_by_genre_for_display(params[:id])
      when "R&B"
        @artists = Item.get_albums_by_genre_for_display(params[:id])
      when "Rap"
        @artists = Item.get_albums_by_genre_for_display(params[:id])
      else
        @artists = Item.get_items_for_display("mp3s")
       
    end
    
    render :layout => false
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
    end
    session[:cart] = session[:cart].uniq
    redirect_to("/items/music")
  end

  def cart
  end

end
