class CreateCommentsRelationships < ActiveRecord::Migration
  def self.up
    create_table :comments_relationships do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :comments_relationships
  end
end
