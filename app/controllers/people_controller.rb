class PeopleController < ApplicationController
  def index
    @people = User.page(params[:page]).per(5)
    @loc = current_user.location
  end
end
