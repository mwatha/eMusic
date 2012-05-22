class UsersController < ApplicationController
=begin
  def login
    #render :layout => false
  end
=end

  def signup
    @terms_of_condtion =<<EOF
<p>These Terms of Service ("Terms") govern your access to and use of the services and eMusic’s websites (the "Services"), and any information, text, graphics, photos or other materials uploaded, downloaded or appearing on the Services (collectively referred to as "Content"). Your access to and use of the Services is conditioned on your acceptance of and compliance with these Terms. By accessing or using the Services you agree to be bound by these Terms.</p>

<h3>Basic Terms</h3>

<p>You are responsible for your use of the Services, for any Content you post to the Services, and for any consequences thereof. The Content you submit, post, or display will be able to be viewed by other users of the Services and through third party services and websites (go to the account settings page to control who sees your Content). You should only provide Content that you are comfortable sharing with others under these Terms.</p>

<p>What you say on eMusic may be viewed all around the world instantly. You are what you Tweet!<p>

<p>You may use the Services only if you can form a binding contract with eMusic and are not a person barred from receiving services under the laws of the United States or other applicable jurisdiction. You may use the Services only in compliance with these Terms and all applicable local, state, national, and international laws, rules and regulations.</p>

<p>The Services that eMusic provides are always evolving and the form and nature of the Services that eMusic provides may change from time to time without prior notice to you. In addition, eMusic may stop (permanently or temporarily) providing the Services (or any features within the Services) to you or to users generally and may not be able to provide you with prior notice. We also retain the right to create limits on use and storage at our sole discretion at any time without prior notice to you.</p>

<p>The Services may include advertisements, which may be targeted to the Content or information on the Services, queries made through the Services, or other information. The types and extent of advertising by eMusic on the Services are subject to change. In consideration for eMusic granting you access to and use of the Services, you agree that eMusic and its third party providers and partners may place such advertising on the Services or in connection with the display of Content or information from the Services whether submitted by you or others.</p>
Privacy

<p>Any information that you provide to eMusic is subject to our Privacy Policy, which governs our collection and use of your information. You understand that through your use of the Services you consent to the collection and use (as set forth in the Privacy Policy) of this information, including the transfer of this information to the United States and/or other countries for storage, processing and use by eMusic. As part of providing you the Services, we may need to provide you with certain communications, such as service announcements and administrative messages. These communications are considered part of the Services and your eMusic account, which you may not be able to opt-out from receiving.</p>

<p>You can opt-out of most communications from eMusic including our newsletter, new follower emails, etc. Please see the Notifications tab of Settings for more.</p>

<h>Passwords</h3>

<p>You are responsible for safeguarding the password that you use to access the Services and for any activities or actions under your password. We encourage you to use "strong" passwords (passwords that use a combination of upper and lower case letters, numbers and symbols) with your account. eMusic cannot and will not be liable for any loss or damage arising from your failure to comply with the above requirements.</p>
EOF
    #render :layout => false
  end

  def create
    person = People.new()
    person.first_name = params[:user]["first_name"]
    person.last_name = params[:user]["last_name"]
    person.birthdate = params[:user]["dob"]
    person.gender = params[:user]["gender"]
    person.save
    
    user = Users.new()
    user.people_id = person.id 
    user.username = params[:user]["username"]
    user.password = params[:user]["password"]
   
    email = PeopleIdentifier.new()
    email.identifier =  params[:user]["email"]
    email.people_id = person.id
    email.identifier_type = PeopleIdentifierType.find_by_name("Email").id
    email.save

    if user.save
      session[:user_id] = user.id
      redirect_to "/" and return   
    end
    redirect_to "/users/signup" and return   
  end
  
  def logout
    reset_session
    session[:user_id] = nil
    redirect_to "/users/login" and return   
  end

  def login
    if request.get?
      reset_session if session[:cart].blank?
    else
      user = Users.new(params[:user])
      logged_in_user = user.try_to_login
      if not logged_in_user.blank?
        session[:user_id] = logged_in_user.user_id
        redirect_to("/") and return
      else
        flash[:error] = "Invalid username or password"
      end      
    end
  end

  def settings
    @partial = params[:id]
    @partial = 'edit_name' if @partial.blank?
    if @partial == 'edit_name' || @partial == 'contact_details'
      @person = Users.current_user.people
    end
  end

  def update
    person = People.find(params[:person_id])
    person.first_name = params[:user]['first_name'] 
    person.last_name = params[:user]['last_name'] 
    person.birthdate = params[:user]['dob'] 
    person.gender = params[:user]['gender'] 
    person.save

    unless params[:user]['password'].blank?
      user = Users.current_user
      user.password = params[:user]['password']
      user.save 
    end
    redirect_to :action => 'settings' and return
  end

  def update_contact_details
    update_identifier("Zip code", params[:address]["zip_code"])                 
    update_identifier("Phone number", params[:address]["phone_number"])         
    update_identifier("Mailing address", params[:address]["mailing_address"])   
    update_identifier("Email", params[:address]["email"])  

    redirect_to :action => 'settings',:id =>'contact_details' and return
  end
  
  def validate_username
    user = Users.find(:first,:conditions => ["username = ?",params[:username]])
    if user
      render :text =>'not validate'.to_json and return
    else
      render :text =>'valide'.to_json and return
    end
  end

end
