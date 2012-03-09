class Songs < ActiveRecord::Migration
  def self.up
    create_table(:songs, :primary_key => 'song_id') do |t|
      t.string :title                                                      
      t.string :genre                                                      
      t.integer :year
      t.integer :item_id
      t.datetime :date_created , :default => Time.now()
      t.boolean :retired , :default => false                                                  
      t.integer :creator_id
      t.interger :retired_by                                                    
      t.datetime :retired_datetime
    end

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE songs                                                       
ADD COLUMN album_id INT(11) AFTER song_id;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE songs                                                       
ADD COLUMN time TIME AFTER title;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE songs                                                       
ADD COLUMN track_number INT(11) AFTER title;                                
EOF

        ActiveRecord::Base.connection.execute <<EOF                             
ALTER TABLE songs                                                       
ADD COLUMN url TEXT AFTER year;                                
EOF

  end

  def self.down
    drop_table :songs
  end
end
