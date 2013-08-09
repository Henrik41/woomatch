class AddAttachmentAvatarToActivityavatars < ActiveRecord::Migration
  def self.up
    change_table :activityavatars do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :activityavatars, :avatar
  end
end
