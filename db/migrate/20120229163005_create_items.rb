class CreateItems < ActiveRecord::Migration
  def self.up
    create_table(:item, :primary_key => 'item_id') do |t|
      t.string :item_type                                                            
      t.text :description
      t.text :image_url                                                      
      t.datetime :date_created ,:default => Time.now()
      t.boolean :retired ,:default => false                                                  
      t.interger :voided_by                                                    
      t.datetime :retired_datetime                                              
      t.string :retired_reason                                                    
    end 
  end

  def self.down
    drop_table :item
  end
end
