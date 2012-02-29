class Albums < ActiveRecord::Migration
  def self.up
    create_table(:albums, :primary_key => 'album_id') do |t|
      t.string :artist                                                      
      t.string :album_title                                                     
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
    drop_table :albums
  end
end
