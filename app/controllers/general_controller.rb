class GeneralController < ApplicationController
  def activity
    @activity = Activity.find(params[:id])
    @user = User.find(@activity.user_id)
  end
end
