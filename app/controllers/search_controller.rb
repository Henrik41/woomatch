class SearchController < ApplicationController
  
  

  def searchactivities
     @user = current_user if current_user
     
     param = params[:search]
     @searchs = Activity.where("title like ?", "%#{param}%" ).last(8)
    
     @result = request.location        
     mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
     
      Time.zone = mytimezone
      @mytime = Time.zone.now

       @loc =  @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s
    respond_to do |format|    
      format.html {}
                
  end
  end
  
  def searchbycity
    @param = params[:q]
    mycoord = Geocoder.coordinates(@param)
    @activity = Activity.near([mycoord[0],mycoord[1]], 70).last(4)
    @loc = @param
    
    mytimezone = NearestTimeZone.to(mycoord[0],mycoord[1])
    Time.zone = mytimezone
    @mytime = Time.zone.now
    
    if  @activity.empty?
        if request.location.nil?
          @loc = 'Paris, Ile de france'  
          @activity = Activity.last(4)
          @mytime = Time.now

        else
          @result = request.location 
            @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s + ', ' + @result.data['country_name'].to_s                 
          
          mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
          @activity = Activity.near(@loc, 400, :order => :distance).order("created_at").last(4)

        end
    end
      respond_to do |format|    
        format.js {}
      end
    
    
  end
  
  def activitysearch
       
    @user = current_user   
    mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
    Time.zone = mytimezone
    @mytime = Time.zone.now
    
     if params[:location].present?
       @search = Activity.near(params[:location],100).ransack(params[:q])      
 
     else
       @search = Activity.ransack(params[:q])
      
      end
         @activities = @search.result(distinct: true)
         @activitiesrecent =  @activities.order('created_at DESC').page(params[:page]).per(8)
         @activitiesnear   =  @activities.order('created_at DESC').near([@user.latitude,@user.longitude],50).page(params[:page]).per(8)
         @activitiespop    =  @activities.joins(:visit).order('total_visits DESC').near(@user.location,200).page(params[:page]).per(8)
     
    @loc = current_user.location
    @people = User.near([@user.latitude,@user.longitude], 150).last(9)
    
    

  end
  
  def peoplesearch
   
      @result = request.location        
      @mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
  
      @param = params[:q]
      @loc = @param
     if request.location == nil
      @people = User.find(:all).last(10)
     else
      @people = User.near(@param, 100).order("created_at").order("distance").page(params[:page]).per(8)
     end 
     

  respond_to do |format|    
    format.html {}
  end
 end
  
end
