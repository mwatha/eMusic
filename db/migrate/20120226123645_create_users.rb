class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users, :primary_key => 'user_id') do |t|
      t.string :username                                                             
      t.string :password 
      t.string :salt                                                      
      t.integer :people_id
      t.datetime :date_created , :default => Time.now()
      t.boolean :retired , :default => false                                                  
      t.integer :creator_id
      t.interger :retired_by                                                    
      t.datetime :retired_datetime
      t.string :retired_reason                                                    
    end
  end

  def self.down
    drop_table :users
  end
end
