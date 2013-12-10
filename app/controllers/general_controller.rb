class GeneralController < ApplicationController
  def activity
    @activity = Activity.find(params[:id])
    @user = User.find(@activity.user_id)
    @useractivity = @user
    @activity2 = Activity.find(params[:id])
      @whos_following = @activity.followers
    
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
    
    @activity2 = Activity.find(params[:id])
    @activity2.liked_by current_user
    respond_to do |format|
       format.js {}
    end
  end
  
  def unfollow2
      @activity2 = Activity.find(params[:id])
      @activity2.unliked_by current_user
      respond_to do |format|
         format.js {}
      end
    
  end
  
  def follow3
    @useraccepted = User.find(params[:id])
    @activity2 = Activity.find(params[:activity])
    @votes = @activity2.likes.where(:voter_id => @useraccepted)
    @userparticipating = @activity2.votes.where(:vote_scope => nil).map(&:voter)
    
    if @votes.empty?
    else
    @votes[0].vote_scope = 'accept'
    @votes[0].save
    end
    
    
    respond_to do |format|
        format.js {}
    end
    
  end
  
  def follow4
     @useraccepted = User.find(params[:id])
     @activity2 = Activity.find(params[:activity])
     @votes = @activity2.votes.where(:voter_id => @useraccepted)
     
     if @votes.empty?
     else
       @votes.each do |v|
         v.vote_scope = nil
         v.save
       end
     end
     
     @activity2.unliked_by @useraccepted
        
     
  end
  
  def unfollow3
    @useraccepted = User.find(params[:id])
    @activity2 = Activity.find(params[:activity])
    @activity2.unliked_by @useraccepted
    
    
    respond_to do |format|
        format.js {}
    end
  end
  
  def followall
    @activity = Activity.find(params[:id])
    @userparticipating = @activity.votes.where(:vote_scope => nil).map(&:voter)
      
    @userparticipating.each do |c|
      @votes = @activity.likes.where(:voter_id => c.id)
      
      if @votes.empty?
       else
         @votes.each do |v|
           v.vote_scope = 'accept'
           v.save
         end
       end
       
    end
    
    respond_to do |format|
         format.js {}
     end
     
  end
  
  end