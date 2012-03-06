class CreateRelationships < ActiveRecord::Migration
  def self.up
=begin
    create_table(:relationships , :id => false) do |t|                                               
      t.interger :parent                                                              
      t.interger :child                                                       
    end
=end
    create_table(:relationships, :id => false) do |t|
      t.column :parent, :integer
      t.column :child, :integer
    end 
  end

  def self.down
    drop_table :relationships
  end
end
