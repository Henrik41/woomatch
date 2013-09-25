class SearchController < ApplicationController
  def searchactivities
    param = params[:activity_title]
    @searchs = Activity.where("title like ?", "%#{param}%" )
    respond_to do |format|    
      format.html
                
  end
  end
  
  def searchbycity
    param = params[:q]
    @searchs = Activity.near("%#{param}%", 200)
  
  end
  
end
