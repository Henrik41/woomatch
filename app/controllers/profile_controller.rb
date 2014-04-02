class ProfileController < ApplicationController
 
 before_filter :authenticate_user!
  def edit
   @user = current_user
   @useronline = User.online.find(:all, :limit => 9)
   @loc = @user.location
   @interestcount = @user.userinterests.find(:all).count
   @activitiescount = @user.activities.where(:user_id => @user.id).count
   @completion = @user.completion 
   
   if request.location == nil
      @loc = 'Paris, France'  
    else
      
      if @user.location.nil?
      @result = request.location       
      mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
      @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s
    else
      @loc = @user.location
      mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
    end
    end
   

   Time.zone = mytimezone
   @mytime = Time.zone.now
   
   
      @result = @user.location    
      if @result
     
      @activitygrid = Activity.near(@result, 2000).first(7)
      else
      @activitygrid = Activity.find(:all).last(4)
    end
  end
  
  def show
    
    @user = current_user
    @useronline = User.online.find(:all, :limit => 9)
    @loc = @user.location
    @interestcount = @user.userinterests.find(:all).count
    @activitiescount = @user.activities.where(:user_id => @user.id).count
    @completion = @user.completion
    
    @userview = User.find(params[:id])
    @activity = Activity.first
    @useronline = User.online.find(:all, :limit => 9)
    
    
    if request.location == nil
       @loc = 'Paris, France'  
     else

       if @user.location.nil?
       @result = request.location       
       mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
       @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s
     else
       @loc = @user.location
       mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
     end
     end


    Time.zone = mytimezone
    @mytime = Time.zone.now
       
       @activitygrid = Activity.where("user_id = ?", params[:id])
     
  end
  
  def update
    @user = User.find(current_user)
    @interestcount = @user.userinterests.find(:all).count
    @activitiescount = @user.activities.where(:user_id => @user.id).count
    @completion = @user.completion
    @useronline = User.online.find(:all, :limit => 9)
     @activity = @user.activities.all
        @result = request.location    
        if @result
        @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s
        mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)
        @activitygrid = Activity.near(@loc, 200000).last(7)
        else
         mytimezone = NearestTimeZone.to(@result.latitude,@result.longitude)  
        @activitygrid = Activity.find(:all).last(4)
      end
      

       
       Time.zone = mytimezone
       @mytime = Time.zone.now
       
    respond_to do |format|
      if @user.update_attributes(params[:user])
        @user.realage = @user.age.to_i
        @user.save
        format.html { redirect_to '/start/dashboard', notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def follow
    @user = User.find(params[:id])

    if current_user
      if current_user == @user
        flash[:error] = "You cannot follow yourself."
      else
        current_user.follow(@user)
      
        flash[:notice] = "You are now following #{@user.username}."
        redirect_to :back
      end
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}.".html_safe
    end
  end

  def unfollow
    @user = User.find(params[:id])

    if current_user
      current_user.stop_following(@user)
      flash[:notice] = "You are no longer following #{@user.username}."
      redirect_to :back
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.monniker}.".html_safe
    end
  end
  

end
