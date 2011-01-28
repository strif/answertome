class RepEvent < ActiveRecord::Migration
  def self.up
    create_table :rep_events do |t|
      t.references :answer, :null => false
      t.integer "question_id", :null => false
      t.string   "event_type",   :limit => 12, :null => false
      t.integer "user_id", :null => false
      t.integer "author_id",   :null => false
      t.datetime "created_at",   :null => false
    end
  end

  def self.down
        drop_table :rep_events
  end
end



