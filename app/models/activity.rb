class Activity < ActiveRecord::Base
  attr_accessible :about, :end_date, :end_time, :location, :numpart, :price, :recurrent, :start_date, :start_time, :title, :user_id, :website
  attr_accessible :avatar, :longitude, :latitude, :interests_attributes
  geocoded_by :location
  belongs_to :user
  has_many :interests, :dependent => :destroy
  accepts_nested_attributes_for :interests, 
                                   :allow_destroy => true
                                  

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  after_validation :geocode
  before_save { self.start_time = Time.parse(self.start_time.to_s) }
end
