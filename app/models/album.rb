class Album < ActiveRecord::Base
  attr_accessible :user_id, :avatar
  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "250x250>", :thumb => "192x135#" }, :default_url => "/images/:style/missing.png"
  
end
