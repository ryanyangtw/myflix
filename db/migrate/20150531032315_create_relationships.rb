class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :leader_id, index: true
      t.integer :follower_id, index: true
      t.timestamps
    end
  end
end