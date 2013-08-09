class Interest < ActiveRecord::Base
  attr_accessible :activity_id, :interest
  belongs_to :activity
  
end
