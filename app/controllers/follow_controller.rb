class FollowController < ApplicationController
  def ifollow
    @userfollowing = current_user.all_following
  end
  
  def list
 
    @activities = Activity.where("title like ?", "%#{params[:term]}%")
  
      respond_to do |format|
        format.html
        format.json{render :json => @activities.as_json(only: [:title, :about], methods: [:avatar_url])}
      end
  end
  
end
