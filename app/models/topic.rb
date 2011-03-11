class Topic < ActiveRecord::Base
  has_many :questions, :through => :taggings
  has_many :topic_followings
  has_many :users, :through => :topic_followings
  has_many :taggings
  

  scope :recent, order("id ASC")  
  scope :limit50, limit("50")
  scope :at_least_1_user, where("users_count > 0")
  scope :at_least_1_question, where("questions_count > 0")
  scope :most_questioned, at_least_1_question.order("questions_count DESC LIMIT 50")  
  scope :most_followed, at_least_1_user.order("users_count DESC LIMIT 50")

  
  #this will use the name instead of id (/topics/name) instead of (/topics/id)
  def to_param
      "#{name.parameterize}"
  end
  
  
  def self.search(search)
    if search
     where('name  ILIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  
end
