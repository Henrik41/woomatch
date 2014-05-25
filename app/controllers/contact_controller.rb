class ContactController < ApplicationController
  
  def new
     @contact = Contact.new
   end

   def create
     x=params[:contact]
     @contact = Contact.new(x)

     if @contact.valid?
       NotificationsMailer.new_message(@contact).deliver
       redirect_to(root_path, :notice => "Message was successfully sent.")
     else
       flash.now.alert = "Please fill all fields."
       render :new
     end
   end
   
end
