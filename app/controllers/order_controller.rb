class OrderController < ApplicationController
  def view
    @orders = []
    music = ProductCategory.find_by_name("Audio CD album")                      
    video = ProductCategory.find_by_name("Video")                               
    #gadget = ProductCategory.find_by_name("Gadget")

    (session[:cart] || []).each do |cart|
      type = cart.split(":")[0]                                                 
      if type.match(/product_id/i)                                                
        product_id = cart.split(":")[1]                                           
        quantity = cart.split(":")[3].to_i      

        product = Product.find(product_id)                                      
        if product.product_category == music.id                                 
          album = Albums.find_by_product_id(product.id)                         
          album_price = Product.find(album.product_id).price                  
          @orders << [album.artist,album.album_title,album_price,quantity,(quantity * album_price).to_f]
        elsif product.product_type == music.id                                  
        end                                      
      end                                                                       
    end
  end

  def create
    create_identifier("Zip code", params[:address]["zip_code"])
    create_identifier("Phone number", params[:address]["phone_number"])
    create_identifier("Mailing address", params[:address]["mailing_address"])
    create_identifier("Card number", params[:account]["card_number"])
    create_identifier("Pin number", params[:account]["pin_number"])
    create_identifier("Bank card", params[:account]["visa"])

    (session[:cart] || []).each do |cart|
      type = cart.split(":")[0]                                                 
      if type.match(/album_id/i)                                                
        album_id = cart.split(":")[1]                                           
        quantity = cart.split(":")[3].to_i                                          
        album = Albums.find(album_id)                                           
        album_price = ProductPrice.find_by_product_unique_id(album.id).price                  
        create_order(album,album_price,quantity,(quantity * album_price).to_f)
      end                                                                       
    end

    session[:cart] = nil
    redirect_to("/order/thank_you")
  end

  def thank_you
    person = People.find(Users.current_user.people_id)
    @thankyou_message=<<EOF
Thank you #{person.name} for shopping with us.
<p />Your receipt will be sent shortly to: 
<font style="color: orange;">#{person.email}</font>
EOF

  end

  private

  def create_identifier(type,name)
    identifier = PeopleIdentifier.new()
    identifier.identifier_type = PeopleIdentifierType.find_by_name(type).id
    identifier.identifier = name
    identifier.people_id = Users.current_user.people_id
    identifier.save
  end

  def create_order(product,price,quantity,total_cost)
    order = Order.new()
    order.item_type = Item.find(product.item_id).item_type
    order.product_unique_id = product.id
    order.order_status = 0
    order.orderer = Users.current_user.id
    order.start_date = Time.now()
    order.end_date = Time.now() + 2.week
    order.save

    product_order = ProductOrder.new()
    product_order.order_id = order.id
    product_order.price = price
    product_order.quantity = quantity
    product_order.total_cost = total_cost
    product_order.save
  end

end
