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
    @events = PublicActivity::Activity.order('created_at DESC')
  end
  

end
