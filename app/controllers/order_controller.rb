class OrderController < ApplicationController
  def view
    @orders = []
    music = ProductCategory.find_by_name("Audio CD album")                      
    video = ProductCategory.find_by_name("Video")                               
    gadget = ProductCategory.find_by_name("Gadget")

    (session[:cart] || []).each do |cart|
      type = cart.split(":")[0]                                                 
      if type.match(/product_id/i)                                                
        product_id = cart.split(":")[1]                                           
        quantity = cart.split(":")[3].to_i      

        next if product_id == '0'

        product = Product.find(product_id)                                      
        if product.product_category == music.id                                 
          album = Albums.find_by_product_id(product.id)                         
          album_price = Product.find(album.product_id).price                  
          @orders << [album.artist,album.album_title,album_price,quantity,(quantity * album_price).to_f,album.product_id]
        elsif product.product_category == video.id                                  
          video = Video.find_by_product_id(product.id)                         
          video_price = Product.find(video.product_id).price                  
          @orders << [video.title,video.category,video_price,quantity,(quantity * video_price).to_f,video.product_id]
        elsif product.product_category == gadget.id                                  
          gadget = Gadget.find_by_product_id(product.id)                         
          gadget_price = Product.find(gadget.product_id).price                  
          @orders << [gadget.name,gadget.version,gadget_price,quantity,(quantity * gadget_price).to_f,gadget.product_id]
        end                                      
      end                                                                       
    end
  end

  def create
    #music = ProductCategory.find_by_name("Audio CD album")                      
    #video = ProductCategory.find_by_name("Video")                               
    #gadget = ProductCategory.find_by_name("Gadget")

    create_identifier("Zip code", params[:address]["zip_code"])
    create_identifier("Phone number", params[:address]["phone_number"])
    create_identifier("Mailing address", params[:address]["mailing_address"])
    create_identifier("Card number", params[:account]["card_number"])
    create_identifier("Email", params[:address]["email"])

    @order = Order.new()
    @order.order_status = 0
    @order.orderer = Users.current_user.id
    @order.start_date = Time.now()
    @order.end_date = Time.now() + 2.week
    @order.save

    (session[:cart] || []).each do |cart|
      type = cart.split(":")[0]                                                 
      if type.match(/product_id/i)                                                
        product_id = cart.split(":")[1]                                           

        next if product_id == '0'

        quantity = cart.split(":")[3].to_i                                          
        product = Product.find(product_id)                                      
        create_order(@order,product,quantity) 
=begin
        if product.product_category == music.id
          @orders << [video.title,video.category,video_price,quantity,(quantity * video_price).to_f]
        elsif product.product_category == video.id
          @orders << [video.title,video.category,video_price,quantity,(quantity * video_price).to_f]
        end
=end
      end
    end

    @details = ShippingDetails.new()
    @details.order_id = @order.id
    @details.mailing_address = params[:address]["mailing_address"]
    @details.pin = params[:account]["pin_number"]
    @details.card_type = params[:account]["card_number"]
    @details.phone_number = params[:address]["phone_number"]
    @details.email = params[:address]["email"]
    @details.save

    session[:cart] = nil
    redirect_to :action => "thank_you",:id => @order.id,:shipping_id => @details.id
  end

  def thank_you
    @orders = Order.find(params[:id]).get_products
    @shipping_details = ShippingDetails.find(params[:shipping_id])
    person = People.find(Users.current_user.people_id)
    @thankyou_message=<<EOF
Thank you #{person.name} for shopping with us.
<p />Your receipt will be sent shortly to: 
<font style="color: orange;">#{@shipping_details.email}</font>
EOF

  end

  def confirm_details
    person = People.find(Users.current_user.people_id)
    @pemail = person.email
    @paddress = person.address
    @phone = person.phone_number
    @pzip = person.zip_code
  end

  def buy_song
    if request.post?
      order = Order.new()                                                        
      order.order_status = 0                                                     
      order.orderer = Users.current_user.id                                      
      order.start_date = Time.now()                                              
      order.end_date = Time.now()                                     
      order.save

      create_order(order,Product.find(params[:product_id]),1)
      redirect_to :action =>'mp3_download',
        :order_id => order.id and return
    end
    @product_id = params[:id]
  end

  def mp3_download
    if params[:order_id]
      order = Order.find(params[:order_id])
      @order = order.get_products
    end
  end

  def download
    order = Order.find(params[:id])
    product_id = ProductOrder.find_by_order_id(order.id).product_id

    if order.instruction.blank?
      song = Songs.find_by_product_id(product_id)
      order.instruction = song.url
      order.save
      start_download(song)
      return 
      render :text => "Downloading ......." and return
    end
    redirect_to('/')
  end

  def remove_from_shopping_cart
    remove_from_cart(params[:id].to_i)
    redirect_to :action => 'view' and return
  end

  private
=begin
  def create_identifier(type,name)
    identifier_type = PeopleIdentifierType.find_by_name(type).id
    available = PeopleIdentifier.find(:first,:conditions =>["people_id = ? 
                AND identifier_type = ?",Users.current_user.people_id,identifier_type])

    return unless available.blank?

    identifier = PeopleIdentifier.new()
    identifier.identifier_type = identifier_type
    identifier.identifier = name
    identifier.people_id = Users.current_user.people_id
    identifier.date_created = Time.now()
    identifier.save
  end
=end
  def create_order(order,product,quantity)
    product_order = ProductOrder.new()
    product_order.order_id = order.id
    product_order.product_id = product.id
    product_order.price = product.price
    product_order.quantity = quantity
    product_order.total_cost = (quantity * product.price).to_f
    product_order.description = ""
    product_order.save

    if not product.product_category == ProductCategory.find_by_name('Audio Song').id
      product.quantity = (product.quantity - quantity)
      product.save
    end
  end

  def start_download(song)
    send_file(RAILS_ROOT + song.url,:filename => song.title,
      :type => 'application/msword', :disposition => 'inline')
    return
  end

end
