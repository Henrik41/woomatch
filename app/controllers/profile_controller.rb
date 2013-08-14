class ProfileController < ApplicationController
  def index
    @user = current_user
    @activity = @user.activities.all
  end
  
  def show
  end
  
  def update
    @user = User.find(current_user)

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to '/start/index', notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
