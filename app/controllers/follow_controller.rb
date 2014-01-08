class FollowController < ApplicationController
  def ifollow
    @userfollowing = current_user.following_by_type('User')
    @activityfollowing = current_user.following_by_type('Activity')
  end
  
  def list
 
    @activities = Activity.where("title like ?", "%#{params[:term]}%").last(8)
  
      respond_to do |format|
        format.html
        format.json{render :json => @activities.as_json(only: [:title, :about], methods: [:avatar_url])}
      end
  end
  
end
