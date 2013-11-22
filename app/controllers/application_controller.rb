class ApplicationController < ActionController::Base
  include PublicActivity::StoreController 
  protect_from_forgery
  around_filter :user_time_zone, if: :current_user
  
  private
  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
  
  def after_sign_in_path_for(resource_or_scope)
    '/start/dashboard'
  end
  

end
