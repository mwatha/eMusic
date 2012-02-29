class Songs < ActiveRecord::Migration
  def self.up
    create_table(:songs, :primary_key => 'song_id') do |t|
      t.interger :album_id 
      t.string :title                                                      
      t.interger :track_number                                                      
      t.string :genre                                                      
      t.interger :minutes                                                      
      t.integer :year
      t.integer :item_id
      t.datetime :date_created , :default => Time.now()
      t.boolean :retired , :default => false                                                  
      t.integer :creator_id
      t.interger :retired_by                                                    
      t.datetime :retired_datetime
    end
  end

  def self.down
    drop_table :songs
  end
end
