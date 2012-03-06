class UserMailer < ActionMailer::Base
  #default :from => "mwathabwanali@gmail.com"

  def welcome_email(recipient)
    recipients recipient
    subject    "[Signed up] Welcome #{recipient}"
    from       "mwatha@ymail.com"
    body       :recipient => recipient
  end

end
