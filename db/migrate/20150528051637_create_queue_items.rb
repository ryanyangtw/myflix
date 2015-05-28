class CreateQueueItems < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.integer :video_id, index: true
      t.integer :user_id, index: true
      t.integer :position
      t.timestamps

    end
  end
end
