class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|                                               
      t.string :username                                                              
      t.string :password                                                       
      t.interger :creator                                                       
      t.datetime :date_created ,:default => Time.now()
      t.boolean :retired ,:default => false                                                  
      t.interger :retired_by                                                    
      t.datetime :retired_datetime                                              
      t.string :retired_reason                                                    
    end 
  end

  def self.down
    drop_table :users
  end
end
