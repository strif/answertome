class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question, :counter_cache => true
  has_many :rep_events, :class_name => "RepEvent", :foreign_key => "answer_id", :dependent => :destroy
   
   scope :approved, where("status = ?", "approved") 
   scope :by_votes, approved.order("votes desc,created_at asc")     
   scope :newest_first, approved.order("created_at desc")   
   scope :newest_last, approved.order("created_at asc")   
   
        

   
   
   
   
end
