class NotifController < ApplicationController
  
  def index
    @messages = Notif.all
  end

  def create
    @message = Notif.create!(params[:notif])
     end
end