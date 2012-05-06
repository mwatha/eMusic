class BlogController < ApplicationController
  def comments
    @comments = []
  end

  def post
    if request.post?
      redirect_to :action => "comments" and return
    end   
  end

end
