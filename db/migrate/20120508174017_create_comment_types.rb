class CreateCommentTypes < ActiveRecord::Migration
  def self.up
    create_table :comment_types do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :comment_types
  end
end
