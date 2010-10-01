class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, :counter_cache => true
  has_many :rep_events, :class_name => "RepEvent", :dependent => :destroy
  
end
