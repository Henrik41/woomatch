class StartController < ApplicationController
  def index
    if request.location == nil
    else
    @result = request.location    
    
    @mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
    @pond = Pond.new
    
    @timenowuser = DateTime.now.in_time_zone(@mytimezone)
 
  end
  end
  
end
