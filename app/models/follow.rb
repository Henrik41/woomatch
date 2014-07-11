class Follow < ActiveRecord::Base
  
  include PublicActivity::Model
  tracked except: :delete, owner: Proc.new{ |controller, model| controller.current_user }
  
  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true, :dependent => :destroy
  belongs_to :follower,   :polymorphic => true, :dependent => :destroy

  def block!
    self.update_attribute(:blocked, true)
  end

end
