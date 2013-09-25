class ProfileController < ApplicationController
  
autocomplete :userinterest, :interest

  def index
    @user = current_user
    @activity = @user.activities.all
      @result = request.location    
      if @result
      @loc = @result.data['city'].to_s + ', ' + @result.data['region_name'].to_s
      @activitygrid = Activity.near(@loc, 200000).last(7)
      else
      @activitygrid = Activity.find(:all).last(4)
    end
  end
  
  def show
    @user = current_user
    @userview = User.find(params[:id])
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
