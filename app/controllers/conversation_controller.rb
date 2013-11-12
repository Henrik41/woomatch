class ConversationController < ApplicationController

before_filter :get_mailbox

  def index
 
    @user_receiver = User.find(params[:id])
    
  end
  
  def sendmail
    
    
    @para1 = params[:user][:body]
    @para2 = params[:id]

    
    @user_receiver = User.find(@para2)
    
    conv_check_1 = Conversation.participant(@user_receiver)
    conv_check_2 = Conversation.participant(current_user)
    
    @dialog = (conv_check_1 & conv_check_2).first
    
    if @dialog.nil? or !@dialog.is_participant?(current_user)
       current_user.send_message(@user_receiver, @para1, 'subject')
    else
      current_user.reply_to_conversation(@dialog, @para1)
    end

    redirect_to :action => :myinbox
    
    
     
  end
  
  
  def myinbox
    
    @conversations =  @mailbox.inbox.page(params[:page]).per(5)
    @messages_count = @mailbox.inbox({:read => false}).count
    @checkuser = current_user.nearbys(100,:order => :distance).find(:all, :limit => 2)
 
  end
  
  def myoutbox
    
    @conversations =  @mailbox.sentbox
    @messages_count = @mailbox.sentbox.count
 
  end
  def show
     @conversation = @mailbox.conversations.find(params[:id])
     current_user.mark_as_read(@conversation)
  end
  

  def create
    recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all

    conversation = current_user.
      send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end

  def reply
    conversation = Conversation.find(params[:user][:conversation_id])
    current_user.reply_to_conversation(conversation, params[:user][:body], 'this is a reply')
    redirect_to conversation_myinbox_path
  end

  def trash
    conversation = Conversation.find(params[:conversation_id])
    conversation.move_to_trash(current_user)
    redirect_to :action => :myinbox
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
  

  def get_mailbox
      @mailbox = current_user.mailbox
    end
   
  def get_actor
       @actor = current_user
  end
  
  
end
