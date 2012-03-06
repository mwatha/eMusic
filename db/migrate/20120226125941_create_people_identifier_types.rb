class CreatePeopleIdentifierTypes < ActiveRecord::Migration
  def self.up
    create_table(:people_identifier_type, :primary_key => 'people_identifier_type_id') do |t|
      t.string :name                                                              
      t.text :description                                                    
      t.interger :creator                                                       
      t.datetime :date_created ,:default => Time.now()
      t.boolean :retired ,:default => false                                                  
      t.interger :voided_by                                                    
      t.datetime :retired_datetime                                              
      t.string :retired_reason                                                    
    end 
  end

  def self.down
    drop_table :people_identifier_type
  end
end
