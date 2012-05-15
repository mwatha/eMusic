class Comment < ActiveRecord::Base
  set_table_name :comments
  set_primary_key :comment_id

  def sub_comments
    comment_type = CommentType.find_by_name("Child").id
    comments = Comment.find(:all,:joins =>"INNER JOIN comments_relationship r
      ON r.child_comment_id = comments.comment_id 
      AND comments.comment_type=#{comment_type}",
      :conditions =>["r.parent_comment_id = ?",self.id])

    (comments || []).collect do |c|
      [c.comment,Users.find(c.creator).people.name,c.date_created]
    end
  end

  def self.get_comments(product_id)
    comment_type = CommentType.find_by_name("Parent").id
    self.find(:all,:conditions =>["comment_type=? AND product_id=?",comment_type,product_id])
  end

end
