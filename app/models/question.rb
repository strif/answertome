class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, :dependent => :destroy  
  has_many :taggings, :dependent => :destroy  
  has_many :topics, :through => :taggings, :include => [:users]


   validates :title,
             :presence => true,
             :uniqueness => true,
             :length => {:minimum => 10, :maximum => 120}
           
   validates :body,
             :presence => true,
             :length => {:maximum => 4096}
             
    scope :recent, order("created_at DESC")  
    scope :approved, where("status = ?", "approved")       
    scope :answered, approved.recent.where("answers_count > ?", 0)
    scope :with_no_answer, approved.recent.where("answers_count IS NULL")
      
    attr_writer :topic_names
    after_save :assign_topics   
    
    
    def to_param
        "#{id}-#{title.parameterize}"
    end
          
    #This returns selects all the topics of a given question and it 
    # returns them back in a line.
    def topic_names
     @topic_names || topics.map(&:name).join(' ')    
    end
    
    
    private
    
    
    # # This will split and find or create a topic  for each of the words
    # that had problem decreasing the counter
    #  def assign_topics
    #   if @topic_names
    #     self.topics = @topic_names.split(/\s+/).map do |name|
    #     Topic.find_or_create_by_name(name)
    #   end
    #   end
    # end
    
    
    def assign_topics 
     if @topic_names 
      new_topics = @topic_names.split(/\s+/).map do |name| 
       Topic.find_or_create_by_name(name) 
      end 
      # destroy taggings to decrement counter cache 
      self.taggings.each do |t| 
        t.destroy if !new_topics.collect(&:id).include?(t.topic_id) 
      end 
      # assign any new tags 
      self.topics = new_topics
     end 
    end
  
  
end
