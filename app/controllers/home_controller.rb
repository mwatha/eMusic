class HomeController < ApplicationController
  def index
    #render :layout => false
  end

  def cancel_order
    session[:cart] = nil
    redirect_to('/home')
  end

end
