class EmailerController < ApplicationController
  def sendmail
    redirect_to :controller => 'home', :action => 'index'
    return
    email = params["email"]
    recipient = "mwathabwanali@gmail.com"
    subject = params["subject"]
    message = params["message"]
      Emailer.deliver_contact(recipient, subject, message)
      return if request.xhr?
      render :text => 'Message sent successfully' and return
  end 
end
