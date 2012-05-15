# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all heilpers, all the time
  #before_filter :authorize, :intialize_cart, :authorize_order , :except => ["login","logout"]
  before_filter :authorize, :authorize_order , :except => ["login","logout"]

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
    music = ProductCategory.find_by_name("Audio CD album")
    video = ProductCategory.find_by_name("Video")
    gadget = ProductCategory.find_by_name("Gadget")

    (session[:cart] || []).each do |cart|   
      type = cart.split(":")[0]                                                 
      if type.match(/product_id/i)                                                
        product_id = cart.split(":")[1]                                           
        quantity = cart.split(":")[3]                                           
        next if product_id == "0"                                  
        product = Product.find(product_id) rescue nil
        if product.product_category == music.id                                     
          album = Albums.find_by_product_id(product.id)
          @cart << ["#{album.artist}::#{album.album_title}::#{quantity}::#{product.id}"]                      
        elsif product.product_category == video.id                                     
          video = Video.find_by_product_id(product.id)
          @cart << ["#{video.title}::#{video.category}::#{quantity}::#{product.id}"]                      
        elsif product.product_category == gadget.id                                     
          gadget = Gadget.find_by_product_id(product.id)
          @cart << ["#{gadget.name}::#{gadget.version}::#{quantity}::#{product.id}"]                      
        end
      end                                                                       
    end
    @cart
  end

  def authorize_order
    if action_name == 'confirm_details' and controller_name == "order"
      redirect_to "/users/login" 
    elsif action_name == 'thank_you' and controller_name == "order"
      redirect_to "/home" 
    end if Users.current_user.blank?
  end
  
  def add_to_cart                                                               
    quantity = params[:quantity].to_i                                           
    product_id = params[:product_id].to_i                                       
    if session[:cart].blank?                                                    
      session[:cart] = ["product_id:#{product_id}:quantity:#{quantity}"]        
    end                                                                         
    unless session[:cart].include?("product_id:#{product_id}:quantity#{quantity}")
      session[:cart] << "product_id:#{product_id}:quantity:#{quantity}"         
    end                                                                         
    roundedOrders = Hash.new(0)                                                 
    (session[:cart]).uniq.each do |cart|                                        
      product_id = cart.split(':')[0..1].join(':')                              
      quantity = cart.split(':')[3].to_i                                        
      roundedOrders[product_id]+= quantity                                      
    end                                                                         
    session[:cart] = []                                                         
    roundedOrders.each do |key , quantity|                                      
      session[:cart] << "#{key}:quantity:#{quantity}"                           
    end                                                                         
    session[:cart] = session[:cart].uniq                                        
    render :text => intialize_cart.to_json and return                           
  end
end
