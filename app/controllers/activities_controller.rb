class ActivitiesController < ApplicationController
  
 require 'flickraw'
 before_filter :authenticate_user!

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

 
  def myactivities
     @user = current_user
    
     mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
     Time.zone = mytimezone
     @mytime = Time.zone.now
      
     
     @activitypast = @user.activities.where("ending < ?", @mytime)
     @activitynow = @user.activities.where("ending >= ?", @mytime)
       
        @result = @user.location    
        if @result
        @activitygrid = Activity.near(@result, 200000).find(:all, :order => "updated_at").first(7)
        else
        @activitygrid = Activity.find(:all).last(4)
      end
      
  end
  # GET /activities/1
  # GET /activities/1.json
  def show
    @user = current_user
    
    @activity = @user.activities.find(params[:id])
    
    if @activity.visit.nil?
      Visit.track(@activity,current_user) 
    end
    
    @visitor = VisitDetail.where(:visit_id => @activity.visit.id).last   
    @visitorob = User.find(@visitor.ip_address)
    
    @useractivity = @user
    @whos_following = @activity.followers
    
      if NearestTimeZone.to( @activity.latitude, @activity.longitude)
        @mytime = NearestTimeZone.to( @activity.latitude, @activity.longitude)
        @timenow = Time.now.in_time_zone(@mytime)
      else
        @timenow = Time.now
      end
    
   
    @userparticipating = @activity.votes.where(:vote_scope => nil).map(&:voter)    
    @userparticipating2 = @activity.votes.where(:vote_scope => 'accept').map(&:voter).uniq

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    
  
       


    @activity = current_user.activities.new
    @useronline = User.online.find(:all, :limit => 9)
    if @useronline.empty?
      @useronline = User.find(:all, :limit =>9)
    else 
      @useronline = User.online.find(:all, :limit => 9)
    end
    @user = current_user
   
    mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
    Time.zone = mytimezone
    @mytime = Time.zone.now
 
     @result = @user.location    
     if @result
     @activitygrid = Activity.near(@result, 200000).first(7)
     else
     @activitygrid = Activity.find(:all).last(4)
   end
   

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    
    @user = current_user
    @interestcount = @user.userinterests.find(:all).count
    @activitiescount = @user.activities.where(:user_id => @user.id).count      
    @useronline = User.online.find(:all, :limit => 9)
    @activity = current_user.activities.find(params[:id])
    @completion2 = @activity.completion2
    mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
    Time.zone = mytimezone
    @mytime = Time.zone.now     
    @result = @user.location    
       if @result
       @activitygrid = Activity.near(@result, 200000).first(7)
       else
       @activitygrid = Activity.find(:all).last(4)
     end
  end

  # POST /activities
  # POST /activities.json
  def create
    
    @user = current_user
    @activity = current_user.activities.create(params[:activity])      
    @activity.start_time = params[:s1Time1]
    @activity.end_time = params[:s1Time2]
    @useronline = User.online.find(:all, :limit => 9)
    mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
     Time.zone = mytimezone
     @mytime = Time.zone.now
      @result = @user.location    
       if @result
       @activitygrid = Activity.near(@result, 200000).first(7)
       else
       @activitygrid = Activity.find(:all).last(4)
     end
    
    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @user = current_user
    @activity = current_user.activities.find(params[:id])  
   
    @activity.start_time = params[:s1Time1]
    @activity.end_time = params[:s1Time2]
    @useronline = User.online.find(:all, :limit => 9)
     mytimezone = NearestTimeZone.to(@user.latitude,@user.longitude)
       Time.zone = mytimezone
       @mytime = Time.zone.now
    @result = @user.location    
          if @result
          @activitygrid = Activity.near(@result, 200000).first(7)
          else
          @activitygrid = Activity.find(:all).last(4)
        end
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
     
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = current_user.activities.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end
  

end
