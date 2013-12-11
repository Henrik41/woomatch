class PeopleController < ApplicationController
  def index
    @people = User.page(params[:page]).per(8)
    @loc = current_user.location
  end
end
