class ItemsController < ApplicationController
  def music
    @artists = Item.get_items_for_display("mp3s")
  end

  def view
    @album = Item.get_album(params[:id])
    @songs = Item.get_album_songs(@album[0][:item_id]) 
  end

end
