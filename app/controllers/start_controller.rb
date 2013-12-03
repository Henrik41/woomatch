class StartController < ApplicationController
  
   
  def index
    if request.location == nil
      @loc = 'Paris, France'  
    else
      @result = request.location        
      mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
      
       Time.zone = mytimezone
       @mytime = Time.zone.now
      
      @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s
    end
    
    if request.location == nil
      @activity = Activity.find(:all).last(4)
    else
      @activity = Activity.near(@loc, 100).order("created_at").last(4)
    end 
     
    @timenowuser = DateTime.now.in_time_zone(@mytimezone)
   
  end
  
  def dashboard
    
    @user = current_user
    @useronline = User.online
    @loc = @user.location
    @interestcount = @user.userinterests.find(:all).count
    @activitiescount = @user.activities.where(:user_id => @user.id).count
    @completion = @user.completion 
    
     if request.location == nil
        @loc = 'Paris, France'  
      else
        @result = request.location       
        mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
        @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s 
      end
      
      
   
    Time.zone = mytimezone
    @mytime = Time.zone.now  		
    @events = Kaminari.paginate_array(PublicActivity::Activity.order('created_at DESC').find(:all,  :conditions => ["key != ?", "follow.destroy"])).page(params[:page]).per(4)
 
  end
  

end
