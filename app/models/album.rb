class Album < ActiveRecord::Base
  attr_accessible :user_id, :avatar
  belongs_to :user

end
