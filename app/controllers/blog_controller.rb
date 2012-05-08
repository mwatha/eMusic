class BlogController < ApplicationController
  def comments
    @comments = Comment.find(:all,:conditions =>["comment_type = ?",
      CommentType.find_by_name("Parent").id])
  end

  def post
    if request.post?
      comment = Comment.new()
      comment.comment = params[:post]
      comment.creator = Users.current_user.id
      comment.comment_type = CommentType.find_by_name("Parent").id
      comment.date_created = Time.now()
      comment.save
      redirect_to :action => "comments" and return
    end   
  end

end
