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
     
     @activitypast = @user.activities.where("end_time <= ?", @mytime)
     @activitynow = @user.activities.where("end_time > ?", @mytime)
     
  
        @result = @user.location    
        if @result
        @activitygrid = Activity.near(@result, 200000).first(7)
        else
        @activitygrid = Activity.find(:all).last(4)
      end
      
  end
  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = current_user.activities.find(params[:id])
    @user = current_user
    
      if NearestTimeZone.to( @activity.latitude, @activity.longitude)
        @mytime = NearestTimeZone.to( @activity.latitude, @activity.longitude)
      else
        @mytime = Time.now
      end
    
    @timenow = Time.now.in_time_zone(@mytime)
    @userparticipating = @activity.votes.map(&:voter)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = current_user.activities.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    
    @user = current_user
    @activity = current_user.activities.find(params[:id])
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
    
    @activity = current_user.activities.create(params[:activity])    
    @activity.start_time = params[:s1Time1]
    @activity.end_time = params[:s1Time2]
    
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
    
    @activity = current_user.activities.find(params[:id])    
    @activity.start_time = params[:s1Time1]
    @activity.end_time = params[:s1Time2]
   
   
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
