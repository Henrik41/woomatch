class Activityavatar < ActiveRecord::Base
  attr_accessible :activity_id
  attr_accessible :avatar
  belongs_to :activity
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
