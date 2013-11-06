class GeneralController < ApplicationController
  def activity
    @activity = Activity.find(params[:id])
    @user = User.find(@activity.user_id)
    @activity2 = Activityapply.find(params[:id])
  end


 
  def follow
    @activity = Activity.find(params[:id])
    current_user.follow(@activity)
    respond_to do |format|
       format.js {}
    end
  end
  
  def unfollow
    @activity = Activity.find(params[:id])
    current_user.stop_following(@activity)
    respond_to do |format|
       format.js {}
    end
  end
  
  
  def follow2
    @activity2 = Activityapply.find(params[:id])
    current_user.follow(@activity2)
    respond_to do |format|
       format.js {}
    end
  end
  
  def unfollow2
    @activity2 = Activityapply.find(params[:id])
    current_user.stop_following(@activity2)
    respond_to do |format|
       format.js {}
    end
  end
  
  end