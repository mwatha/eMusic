class UsersController < ApplicationController
  def login
    render :layout => false
  end

  def signup
    @terms_of_condtion =<<EOF
<p>These Terms of Service ("Terms") govern your access to and use of the services and Twitter’s websites (the "Services"), and any information, text, graphics, photos or other materials uploaded, downloaded or appearing on the Services (collectively referred to as "Content"). Your access to and use of the Services is conditioned on your acceptance of and compliance with these Terms. By accessing or using the Services you agree to be bound by these Terms.</p>

<h3>Basic Terms</h3>

<p>You are responsible for your use of the Services, for any Content you post to the Services, and for any consequences thereof. The Content you submit, post, or display will be able to be viewed by other users of the Services and through third party services and websites (go to the account settings page to control who sees your Content). You should only provide Content that you are comfortable sharing with others under these Terms.</p>

<p>What you say on Twitter may be viewed all around the world instantly. You are what you Tweet!<p>

<p>You may use the Services only if you can form a binding contract with Twitter and are not a person barred from receiving services under the laws of the United States or other applicable jurisdiction. You may use the Services only in compliance with these Terms and all applicable local, state, national, and international laws, rules and regulations.</p>

<p>The Services that Twitter provides are always evolving and the form and nature of the Services that Twitter provides may change from time to time without prior notice to you. In addition, Twitter may stop (permanently or temporarily) providing the Services (or any features within the Services) to you or to users generally and may not be able to provide you with prior notice. We also retain the right to create limits on use and storage at our sole discretion at any time without prior notice to you.</p>

<p>The Services may include advertisements, which may be targeted to the Content or information on the Services, queries made through the Services, or other information. The types and extent of advertising by Twitter on the Services are subject to change. In consideration for Twitter granting you access to and use of the Services, you agree that Twitter and its third party providers and partners may place such advertising on the Services or in connection with the display of Content or information from the Services whether submitted by you or others.</p>
Privacy

<p>Any information that you provide to Twitter is subject to our Privacy Policy, which governs our collection and use of your information. You understand that through your use of the Services you consent to the collection and use (as set forth in the Privacy Policy) of this information, including the transfer of this information to the United States and/or other countries for storage, processing and use by Twitter. As part of providing you the Services, we may need to provide you with certain communications, such as service announcements and administrative messages. These communications are considered part of the Services and your Twitter account, which you may not be able to opt-out from receiving.</p>

<p>You can opt-out of most communications from Twitter including our newsletter, new follower emails, etc. Please see the Notifications tab of Settings for more.</p>

<h>Passwords</h3>

<p>You are responsible for safeguarding the password that you use to access the Services and for any activities or actions under your password. We encourage you to use "strong" passwords (passwords that use a combination of upper and lower case letters, numbers and symbols) with your account. Twitter cannot and will not be liable for any loss or damage arising from your failure to comply with the above requirements.</p>
EOF
    render :layout => false
  end

  def create
    person = People.new()
    person.first_name = params[:user]["first_name"]
    person.last_name = params[:user]["last_name"]
    person.birthdate = params[:user]["birtdate"]
    person.gender = params[:user]["gender"]
    person.save
    
    user = Users.new()
    user.people_id = person.id 
    user.username = params[:user]["username"]
    user.password = params[:user]["password"]
    
    if user.save
      session[:user_id] = user.id
      redirect_to "/home/index" and return   
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
      if logged_in_user
        session[:user_id] = logged_in_user.user_id
        redirect_to("/home/index") and return
      else
        flash[:error] = "Invalid username or password"
      end      
    end
    render :layout => false
  end


end
