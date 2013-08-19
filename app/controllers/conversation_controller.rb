class ConversationController < ApplicationController

  before_filter :setuser

  def index
 
    @user_receiver = User.find(params[:id])
    
  end
  
  def sendmail
    
    @para1 = params[:user][:subject]
    @para2 = params[:id]
    @user_receiver = User.find(@para2)
    @user_sender.send_message(@user_receiver, @para1, 'sujet')
    redirect_to :action => :myinbox  
     
  end
  
  
  def myinbox
    @conversations = @user_sender.mailbox.inbox
  end
  
  
  def create
    recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all

    conversation = current_user.
      send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
  
  private
  
  def setuser
     @user_sender = current_user
  end
  
end
