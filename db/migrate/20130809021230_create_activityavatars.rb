class CreateActivityavatars < ActiveRecord::Migration
  def change
    create_table :activityavatars do |t|
      t.integer :activity_id

      t.timestamps
    end
  end
end
