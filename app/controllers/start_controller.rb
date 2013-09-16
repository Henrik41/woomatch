class StartController < ApplicationController
  
   autocomplete :activity, :title, :extra_data => [:id],  :full => true
   
  def index
    if request.location == nil
    else
    @result = request.location    
    
    @mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)

    
    @timenowuser = DateTime.now.in_time_zone(@mytimezone)
   
  end
  end
  
end
