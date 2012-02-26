class CreatePeopleIdentifierTypes < ActiveRecord::Migration
  def self.up
    create_table :people_identifier_type do |t|                                               
      t.string :name                                                              
      t.text :description                                                    
      t.interger :creator                                                       
      t.datetime :date_created ,:default => Time.now()
      t.boolean :retired ,:default => false                                                  
      t.interger :retired_by                                                    
      t.datetime :retired_datetime                                              
      t.string :retired_reason                                                    
    end 
  end

  def self.down
    drop_table :people_identifier_type
  end
end
