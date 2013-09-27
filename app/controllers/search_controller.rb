class SearchController < ApplicationController
  def searchactivities
    param = params[:search]
    @searchs = Activity.where("title like ?", "%#{param}%" )
    respond_to do |format|    
      format.html
                
  end
  end
  
  def searchbycity
    param = params[:q]
    @searchs = Activity.near("%#{param}%", 200)
  
  end
  
  def activitysearch
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
