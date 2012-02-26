class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|                                               
      t.interger :parent                                                              
      t.interger :child                                                       
    end 
  end

  def self.down
    drop_table :relationships
  end
end
