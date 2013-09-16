class SearchController < ApplicationController
  def searchactivities
    param = params[:activity_title]
    @searchs = Activity.where("title like ?", "%#{param}%" )
   
  end
  
  def searchbycity
    param = params[:q]
    @searchs = Activity.near("%#{param}%", 200)
  
  end
  
end
