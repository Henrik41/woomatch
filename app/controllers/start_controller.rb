class StartController < ApplicationController
  
  before_filter :get_location, :get_time
   
  def index   
     @activity = Activity.near(@loc, 400).order("created_at").last(4)    
  end
  
  def dashboard    
    @user = current_user
    @useronline = User.online.find(:all, :limit => 9)
    @loc = @user.location
    @interestcount = @user.userinterests.find(:all).count
    @activitiescount = @user.activities.where(:user_id => @user.id).count
    @completion = @user.completion 	
    @events = Kaminari.paginate_array(PublicActivity::Activity.order('created_at DESC').where("key <> 'follow.destroy'").delete_if {|x| x.trackable == nil}).page(params[:page]).per(4) 
  end
  
  def accept
    @activity = current_user.activities.create(params[:activity]) 
    puts "ca marche"
    render :js => "window.location = '/activities/49/edit'"

  end
  
private
  
  def get_location
    if request.location.nil?     
      @loc =  "Manhattan, New York, USA"
      @mytimezone = "America/New_York"
    else
      @result = request.location
      @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s + ', ' + @result.data['country_name'].to_s                 
      @mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
    end
    
  end
  
  def get_time   
    Time.zone = @mytimezone
    @mytime = Time.zone.now  
  end
  
  
end
