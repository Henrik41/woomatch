class StartController < ApplicationController
  
   
  def index
    
    if request.location.nil?
      @loc = 'Paris, Ile de france'  
      @activity = Activity.last(4)
    else
      @result = request.location        
      mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
      
      Time.zone = mytimezone
      @mytime = Time.zone.now
      
     @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s + ', ' + @result.data['country_name'].to_s
     @activity = Activity.near(@loc, 100).order("created_at").last(4)
     
    end
 
  end
  
  def dashboard
    
    @user = current_user
    @useronline = User.online.find(:all, :limit => 9)
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
    @events = Kaminari.paginate_array(PublicActivity::Activity.order('created_at DESC').find(:all,  :conditions => ["key != ?", "follow.destroy"]).delete_if {|x| x.trackable == nil}).page(params[:page]).per(4)
 
  end
  
  def accept
    @activity = current_user.activities.create(params[:activity]) 
    puts "ca marche"
    render :js => "window.location = '/activities/49/edit'"
    
 
  
  end
end
