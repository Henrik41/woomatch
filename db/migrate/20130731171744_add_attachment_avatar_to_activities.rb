class AddAttachmentAvatarToActivities < ActiveRecord::Migration
  def self.up
    change_table :activities do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :activities, :avatar
  end
end
