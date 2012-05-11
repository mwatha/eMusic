class Songs < ActiveRecord::Base
  set_table_name :songs
  set_primary_key :song_id

  def artist
    Albums.find(self.album_id).artist
  end

  def album_title
    Albums.find(self.album_id).album_title
  end

end
