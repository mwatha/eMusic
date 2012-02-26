class CreatePeopleIdentifiers < ActiveRecord::Migration
  def self.up
    create_table :people_identifier do |t|                                               
      t.string :identifier                                                              
      t.interger :identifier_type                                                     
      t.interger :people_id                                                       
      t.datetime :date_created ,:default => Time.now()
      t.boolean :retired ,:default => false                                                  
      t.interger :retired_by                                                    
      t.datetime :retired_datetime                                              
      t.string :retired_reason                                                    
    end 
  end

  def self.down
    drop_table :people_identifier
  end
end
