
class Activity < ActiveRecord::Base
  
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  attr_accessible :about, :end_date, :end_time, :location, :numpart, :price, :recurrent, :start_date, :start_time, :title, :user_id, :website
  attr_accessible :avatar, :longitude, :latitude, :interests_attributes, :url
  geocoded_by :location
  belongs_to :user
  has_many :interests, :dependent => :destroy
  accepts_nested_attributes_for :interests, 
                                   :allow_destroy => true
                                  

  after_validation :geocode, :if => :location_changed?

  before_save :startdate, :enddate
  validates_presence_of  :location, :start_time, :end_time
  mount_uploader :avatar, AvatarUploader
  acts_as_followable
  acts_as_votable
  


  def avatar_url
   self.avatar.url(:supermini)
  end
  
  def completion
    if self.numpart.nil?
      100
    else
      self.votes.size.to_f/self.numpart.to_f * 100
    end
  end

  
  def enddate
    
    y = self.end_date.year
    m = self.end_date.month
    d = self.end_date.day
    v = self.end_time
    vh = v.hour
    vm = v.min
    Time.zone =  NearestTimeZone.to(self.latitude,self.longitude)
    self.end_time = Time.zone.local(y.to_i,m.to_i,d.to_i,vh.to_i,vm.to_i)
  end

  
  def startdate
    
    y = self.start_date.year
    m = self.start_date.month
    d = self.start_date.day
    v = self.start_time
    vh = v.hour
    vm = v.min
    Time.zone =  NearestTimeZone.to(self.latitude,self.longitude)
    self.start_time = Time.zone.local(y.to_i,m.to_i,d.to_i,vh.to_i,vm.to_i)

  end
  
  def timezone
    NearestTimeZone.to(self.latitude,self.longitude)
  end
  

end

