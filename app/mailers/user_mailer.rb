class UserMailer < ActionMailer::Base
  default :from => "admin@woomatch.com"
  
  def send_user_accepted(user,activity,current_user)
     @activity = activity
     @current_user = current_user
     mail(:to => user.email, 
          :subject => "You just got accepted!",
          :content_type => "text/html",
          :template_path => 'user_mailer',    
          :template_name => 'send_user_accepted'  
          ) 
  end
  
  def followme(user)
     mail(:to => user.email, 
          :subject => "Someone is follow your activity!",
          :content_type => "text/html",   
          :template_path => 'user_mailer',    
          :template_name => 'send_user_accepted'  
              )
  end
  

end