class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles, :id => false do |t|
      t.primary_key  "user_id",         :null => false
      t.string   "first_name",       :limit => 60
      t.string   "last_name",        :limit => 60
      t.text   "body" 
      t.string   "location",            :limit => 50
      t.datetime "birthday"   
      t.boolean "hide_birthday", :default => true
      t.string   "gender",            :limit => 6
    end
  end

  def self.down
    drop_table :profiles
  end
end
