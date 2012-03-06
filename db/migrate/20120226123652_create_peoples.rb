class CreatePeoples < ActiveRecord::Migration
  def self.up
    create_table(:people, :primary_key => 'people_id') do |t|
      t.string :first_name                                                              
      t.string :last_name                                                     
      t.date :birthdate
      t.string :gender                                                       
      t.datetime :date_created ,:default => Time.now()
      t.boolean :retired ,:default => false                                                  
      t.interger :voided_by                                                    
      t.datetime :retired_datetime                                              
      t.string :retired_reason                                                    
    end
  end

  def self.down
    drop_table :people
  end
end
