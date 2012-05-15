class BlogController < ApplicationController
  def comments
    @comments = Comment.find(:all,:conditions =>["comment_type = ?",
      CommentType.find_by_name("Parent").id])
  end

  def post
    if request.post?
      unless params[:parent_comment_id].blank?
        comment_type = CommentType.find_by_name("Child").id
      else
        comment_type = CommentType.find_by_name("Parent").id
      end

      comment = Comment.new()
      comment.comment = params[:post]
      comment.comment_type = comment_type
      comment.creator = Users.current_user.id
      comment.product_id = params[:product_id]
      comment.date_created = Time.now()
      comment.save

      unless params[:parent_comment_id].blank?
        relationship = CommentsRelationship.new()
        relationship.parent_comment_id = params[:parent_comment_id]
        relationship.child_comment_id = comment.id
        relationship.save
      end

      redirect_to :action => "comments" and return
    elsif request.get?
      unless params[:parent_comment_id].blank?
        @parent_comment_id =  params[:parent_comment_id]  
      end
      product_id = params[:id] ||= params[:parent_comment_id]
      @image_url = Product.find(:first,:joins =>"INNER JOIN product_category p
      ON product_category = p.product_category_id",
      :conditions =>["product_id = ?", product_id]).image_url 
      @product_id = product_id
    end
  end

end
