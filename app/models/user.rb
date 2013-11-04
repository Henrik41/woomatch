class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_many :activities, :dependent => :destroy
  has_many :userinterests, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :userinterests, 
                                    :allow_destroy => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :location, :realage, :dob, :age, :sex, :status, :about, :web, :email, :password, :password_confirmation, :time_zone, :avatar,  :userinterests_attributes
  attr_accessible :longitude, :latitude
  attr_accessible :provider, :uid, :name
  
  attr_accessible :body, :conversation_id
  geocoded_by :location
  mount_uploader :avatar, AvatarUploader
   acts_as_messageable
     acts_as_followable
     acts_as_follower

  after_validation :geocode, :if => :location_changed?
  

  
  def age
      now = Time.now.utc.to_date
      if dob 
      now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1)
    else
    end
  end
  




  def name
     username
   end
  
   def mailboxer_email(object)
     #Check if an email should be sent for that object
     #if true
     return "define_email@on_your.model"
     #if false
     #return nil
   end
   
   def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
     user = User.where(:provider => auth.provider, :uid => auth.uid).first
     unless user
       user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20]
                            )
     end
     user
   end
   
   def self.new_with_session(params, session)
       super.tap do |user|
         if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
           user.email = data["email"] if user.email.blank?
         end
       end
     end
   
end
