class PeopleController < ApplicationController
  def index
    @people = User.all
  end
end
