class GeneralController < ApplicationController
  def activity
    
    unless current_user.nil?
      mytimezone = NearestTimeZone.to(current_user.latitude,current_user.longitude)
      Time.zone = mytimezone
      @mytime = Time.zone.now

      @activity = Activity.find(params[:id])

      @user = User.find(@activity.user_id)
      @userparticipating2 = @activity.votes_for.where(:vote_scope => 'accept').map(&:voter).uniq
      @userparticipating = @activity.votes_for.where(:vote_scope => nil).map(&:voter)    

      @useractivity = @user
      @activity2 = Activity.find(params[:id])
      @whos_following = @activity.followers
      Visit.track(@activity,current_user)  
      
      @peoplevisitingme = Visit.where(:visitable_id => current_user, :visitable_type => "User")
    
       unless @peoplevisitingme[0].nil?
     
      @myvisitor = @peoplevisitingme[0].visit_details.pluck(:ip_address)
      @myvisit = User.find_all_by_id(@myvisitor).last(4)
      
       else
      
       @myvisit = nil
       
       end
    
    else

    
    redirect_to :controller => 'start', :action => 'index'
    end
    
    
  end

 def follow

 
     @activity = Activity.find(params[:id])
     @useraccepted = User.find(@activity.user_id)           
     @current_user2 = current_user
     
    if @useraccepted.followme
       UserMailer.followme(@current_user2,@useraccepted,@activity).deliver
    end
    
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
    
    @current_user2 = current_user
    @useraccepted = User.find(@activity2.user_id) 
    
    if @useraccepted.partime
       UserMailer.partime(@current_user2,@useraccepted,@activity2).deliver
    end
    
    respond_to do |format|
       format.js {}
    end
  end
  
  def unfollow2
      @activity2 = Activity.find(params[:id])
      @activity2.unliked_by current_user
      @activity2.unliked_by current_user, :vote_scope => 'accept'
      respond_to do |format|
         format.js {}
      end
    
  end
  
  def follow3
    @useraccepted = User.find(params[:id])       
    @activity2 = Activity.find(params[:activity])
    @current_user2 = current_user
    if @useraccepted.acceptme
       UserMailer.send_user_accepted(@useraccepted,@activity2,@current_user2).deliver
    end
    
    @votes = @activity2.find_votes_for.where(:voter_id => @useraccepted)
    
    @userparticipating = @activity2.votes_for.where(:vote_scope => nil).map(&:voter)
   
    
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
     @votes = @activity2.votes_for.where(:voter_id => @useraccepted)
     
     if @votes.empty?
     else
       @votes.each do |v|
         v.vote_scope = nil
         v.save
       end
     end
     
     @activity2.unliked_by @useraccepted
        
     
  end
  
  
  def followdash
       @activity = Activity.find(params[:id])
       @useraccepted = User.find(@activity.user_id)           
       @current_user2 = current_user
       
       
      if @useraccepted.followme
         UserMailer.followme(@current_user2,@useraccepted,@activity).deliver
      end

      
      current_user.follow(@activity)
      
      respond_to do |format|
         format.js {}
      end
   
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
    @userparticipating = @activity.votes_for.where(:vote_scope => nil).map(&:voter)
    @activity2 = @activity
    @current_user2 = current_user  
    @userparticipating.each do |c|
        @votes = @activity.votes_for.where(:voter_id => c.id)
         UserMailer.send_user_accepted(c,@activity2,@current_user2).deliver
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
  
  def invite
    
    @activity = Activity.find(params[:id])
    @useraccepted = User.find(@activity.user_id)
    @para1= 'Hey '+@useraccepted.username+'. You are invited to my activity <b>'+'<a href="/activity/'+@activity.id.to_s+'">'+ @activity.title+'</a></b>. Please check it out and let me know what you think! </br> </br>'+'<a href="/activity/'+@activity.id.to_s+'">'+'<img src="'+@activity.avatar.url(:supermini)+'"></a>'
     @following = params[:role_ids]
     @following.each do |f|
       
      @user_receiver = User.find(f)
      
       conv_check_1 = Conversation.participant(@user_receiver)
       conv_check_2 = Conversation.participant(current_user)

       @dialog = (conv_check_1 & conv_check_2).first

       if @dialog.nil? or !@dialog.is_participant?(current_user)
          current_user.send_message(@user_receiver, @para1, 'VIP Invitation', sanitize_text = false, attachment = nil)
       else
          current_user.reply_to_conversation(@dialog, @para1, sanitize_text = false, attachment = nil)
       end
       
       
     end
     respond_to do |format|
          format.html {}
      end   
     
  end
  
  def notification
    @notif = Notif.last(6)
    respond_to do |format|
         format.js { render "notification", :locals => {:notifi => @notif} }
     end
  end
  
  def newsletter
    @email = params[:email]
    respond_to do |format|
         format.js {}
     end
     
  end
  

  
  end