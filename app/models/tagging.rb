class Tagging < ActiveRecord::Base
  belongs_to :question
  belongs_to :topic, :counter_cache => :questions_count
  


  validates_presence_of :topic_id
end
