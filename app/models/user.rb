class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :userinterests, :dependent => :destroy
  accepts_nested_attributes_for :userinterests, 
                                    :allow_destroy => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :location, :dob, :age, :sex, :status, :about, :web, :email, :password, :password_confirmation, :time_zone, :avatar,  :userinterests_attributes
  attr_accessible :longitude, :latitude
  attr_accessible :subject
  geocoded_by :location
  mount_uploader :avatar, AvatarUploader
   acts_as_messageable
  validates_presence_of :username
  validates_uniqueness_of :username
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
   
end
