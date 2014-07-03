class ApplicationController < ActionController::Base
  include PublicActivity::StoreController 
  skip_before_filter :verify_authenticity_token
  protect_from_forgery
  around_filter :user_time_zone, if: :current_user
  before_filter :messages_count, if: :current_user
  before_filter :user_activity
  


  private
  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
  

  
  def user_activity
    current_user.try :touch
  end
  
 
  def messages_count
    @mailbox ||= current_user.mailbox
    @messages_count = @mailbox.inbox({:read => false}).count
  end


   def after_sign_up_path_for(resource_or_scope)
     profilepage_path
   end
  
   def after_sign_in_path_for(resource_or_scope)
     '/start/dashboard'
   end
   

end
