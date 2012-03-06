# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all heilpers, all the time
  before_filter :authorize, :intialize_cart, :authorize_order , :except => ["login","logout"]

  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password


   def authorize                                                                 
    unless session[:user_id].blank?         
      Users.current_user = Users.find(session[:user_id]) 
    else                                                                         
      Users.current_user = nil  
    end                                                                         
  end

  def intialize_cart
    @cart = []                                                                  
    (session[:cart] || []).each do |cart|                                       
      type = cart.split(":")[0]                                                 
      if type.match(/album_id/i)                                                
        album_id = cart.split(":")[1]                                           
        quantity = cart.split(":")[3]                                           
        album = Albums.find(album_id)                                           
        @cart << [album.artist,album.album_title,quantity]                      
      end                                                                       
    end
  end

  def authorize_order
    if action_name == 'confirm_details' and controller_name == "order"
      redirect_to "/users/login" 
    elsif action_name == 'thank_you' and controller_name == "order"
      redirect_to "/home" 
    end if Users.current_user.blank?
  end

end
