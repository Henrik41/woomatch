class Activity < ActiveRecord::Base

  attr_accessible :about, :end_date, :end_time, :location, :numpart, :price, :recurrent, :start_date, :start_time, :title, :user_id, :website
  attr_accessible :avatar, :longitude, :latitude, :interests_attributes
  geocoded_by :location
  belongs_to :user
  has_many :interests, :dependent => :destroy
  accepts_nested_attributes_for :interests, 
                                   :allow_destroy => true
                                  

  after_validation :geocode
  validates_presence_of  :location, :start_time, :end_time
  mount_uploader :avatar, AvatarUploader
  acts_as_followable
  
  def avatar_url
   self.avatar.url(:supermini)
  end
  

end

class Activityapply < Activity
  acts_as_followable
end