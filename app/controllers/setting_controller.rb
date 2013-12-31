class SettingController < ApplicationController
  def index
    @user=current_user
  end
  
  def update
    @user = current_user
     respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to '/start/dashboard', notice: 'Profile was successfully updated.' }
          format.json { head :no_content }
        else
         
        end
      end
    
  end
end