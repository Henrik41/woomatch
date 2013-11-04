class ProfileController < ApplicationController
 

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
    @activity = Activity.first
  end
  
  def update
    @user = User.find(current_user)
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        @user.realage = @user.age.to_i
        @user.save
        format.html { redirect_to '/start/index', notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def follow
    @user = User.find(params[:id])

    if current_user
      if current_user == @user
        flash[:error] = "You cannot follow yourself."
      else
        current_user.follow(@user)
      
        flash[:notice] = "You are now following #{@user.username}."
        redirect_to :back
      end
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}.".html_safe
    end
  end

  def unfollow
    @user = User.find(params[:id])

    if current_user
      current_user.stop_following(@user)
      flash[:notice] = "You are no longer following #{@user.username}."
      redirect_to :back
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.monniker}.".html_safe
    end
  end

end
