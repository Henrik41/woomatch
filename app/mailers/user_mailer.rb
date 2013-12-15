class UserMailer < ActionMailer::Base
  default :from => "Do_not_reply@woomatch.com"
  
  def send_user_accepted(user)
     mail(:to => 'henrik41@hotmail.com', :subject => "You just got accepted!")
  end
  
  def followme(user)
     mail(:to => 'henrik41@hotmail.com', :subject => "Someone is follow your activity!")
  end
end