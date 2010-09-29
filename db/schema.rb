# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100918215858) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id",                                        :null => false
    t.integer  "user_id",                                            :null => false
    t.string   "title",       :limit => 120
    t.text     "body",                                               :null => false
    t.string   "status",      :limit => 12,  :default => "approved", :null => false
    t.datetime "created_at",                                         :null => false
    t.float    "votes"
  end

  create_table "attachings", :id => false, :force => true do |t|
    t.integer "user_id",     :null => false
    t.integer "question_id", :null => false
    t.integer "attached_id", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string "name",   :limit => 100, :null => false
    t.string "parent", :limit => 100
    t.text   "topics"
  end

  create_table "comments", :force => true do |t|
    t.integer  "case_id",                                           :null => false
    t.string   "case_type",  :limit => 12,  :default => "question", :null => false
    t.integer  "user_id",                                           :null => false
    t.string   "body",       :limit => 256,                         :null => false
    t.string   "status",     :limit => 12,  :default => "approved", :null => false
    t.datetime "created_at",                                        :null => false
  end

  create_table "datatypes", :force => true do |t|
    t.integer "user_id",               :null => false
    t.string  "name",    :limit => 60, :null => false
  end

  create_table "infos", :id => false, :force => true do |t|
    t.integer "user_id",                    :null => false
    t.integer "datatype_id",                :null => false
    t.string  "value",       :limit => 100, :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer "idto"
    t.string  "sender",                 :null => false
    t.string  "to_id",                  :null => false
    t.string  "subject"
    t.text    "body",                   :null => false
    t.integer "date_sent",              :null => false
    t.integer "is_read",   :limit => 2, :null => false
    t.integer "is_spam",   :limit => 2, :null => false
    t.integer "is_trash",  :limit => 2, :null => false
    t.integer "is_draft",  :limit => 2, :null => false
    t.integer "is_email",  :limit => 2, :null => false
  end

  create_table "profiles", :id => false, :force => true do |t|
    t.integer  "user_id",                                        :null => false
    t.string   "first_name",    :limit => 60
    t.string   "last_name",     :limit => 60
    t.text     "body"
    t.string   "image",         :limit => 300
    t.string   "location",      :limit => 50
    t.datetime "birthday"
    t.boolean  "show_birthday",                :default => true
  end

  create_table "question_followings", :id => false, :force => true do |t|
    t.integer  "question_id",   :null => false
    t.integer  "user_id",       :null => false
    t.datetime "last_notified"
    t.datetime "last_updated"
  end

  create_table "question_topics", :id => false, :force => true do |t|
    t.integer "question_id", :null => false
    t.integer "topic_id",    :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id",                                              :null => false
    t.string   "title",         :limit => 120,                         :null => false
    t.text     "body",                                                 :null => false
    t.integer  "category_id"
    t.datetime "created_at",                                           :null => false
    t.string   "status",        :limit => 12,  :default => "approved", :null => false
    t.float    "votes_counter"
    t.integer  "answers_count"
  end

  create_table "rep_events", :id => false, :force => true do |t|
    t.integer  "event_id",                                             :null => false
    t.string   "event_type",       :limit => 12, :default => "answer", :null => false
    t.integer  "user_id",                                              :null => false
    t.integer  "affected_user_id",                                     :null => false
    t.datetime "created_at",                                           :null => false
  end

  create_table "settings", :id => false, :force => true do |t|
    t.integer "user_id",                        :null => false
    t.boolean "answered",    :default => true,  :null => false
    t.boolean "questioned",  :default => true,  :null => false
    t.boolean "updated",     :default => false, :null => false
    t.boolean "commented",   :default => false, :null => false
    t.boolean "attached",    :default => true,  :null => false
    t.boolean "messaged",    :default => true,  :null => false
    t.boolean "newsletters", :default => false, :null => false
  end

  create_table "topic_followings", :id => false, :force => true do |t|
    t.integer "topic_id", :null => false
    t.integer "user_id",  :null => false
  end

  create_table "topics", :force => true do |t|
    t.string  "name",            :limit => 60, :null => false
    t.integer "followers"
    t.integer "questions_count"
  end

  create_table "user_followings", :id => false, :force => true do |t|
    t.integer  "followed_id",   :null => false
    t.integer  "user_id",       :null => false
    t.datetime "last_notified"
    t.datetime "last_updated"
  end

  create_table "users", :force => true do |t|
    t.string   "username",        :limit => 40,  :null => false
    t.string   "email",           :limit => 100, :null => false
    t.float    "points_count"
    t.string   "usergroup",       :limit => 20,  :null => false
    t.string   "hashed_password", :limit => 40,  :null => false
    t.integer  "activation"
    t.datetime "created_at",                     :null => false
    t.string   "salt",            :limit => 40,  :null => false
    t.datetime "last_login"
  end

end
