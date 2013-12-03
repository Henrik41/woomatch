class SearchController < ApplicationController
  
  

  def searchactivities
     @user = current_user if current_user
     
     param = params[:search]
     @searchs = Activity.where("title like ?", "%#{param}%" )
    
     @result = request.location        
     mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
     
      Time.zone = mytimezone
      @mytime = Time.zone.now

       @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s
    respond_to do |format|    
      format.html {}
                
  end
  end
  
  def searchbycity
    param = params[:q]
    @searchs = Activity.near("%#{param}%", 200)
  
  end
  
  def activitysearch
       @user = current_user

       mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
        Time.zone = mytimezone
        @mytime = Time.zone.now
    @search = Activity.search(params[:q])
    @activities = @search.result
    @activitiesrecent = @activities.order('created_at DESC')
    @activitiesnear = @activities.near(@user.location)
    @activitiespop =  @activities.order('end_time DESC')
    @loc = current_user.location
    @people = User.near(@loc)
    
    

  end
  
  def peoplesearch
    if request.location == nil
      @loc = 'Montreal, Canada'  
    else
      @result = request.location        
      @mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
      @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s
    end
    
    if request.location == nil
      @people = User.find(:all).last(10)

    else
      @people = User.near(@loc, 100).order("created_at").last(10)
    end 
     
    
    
  end

  
  
end
