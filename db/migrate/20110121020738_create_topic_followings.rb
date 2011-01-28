class CreateTopicFollowings < ActiveRecord::Migration
  def self.up
    create_table :topic_followings do |t|
      t.references :user
      t.references :topic      
    end
  end

  def self.down
    drop_table :topic_followings
  end
end
