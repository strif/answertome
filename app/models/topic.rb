class Topic < ActiveRecord::Base
  has_many :questions, :through => :taggings
  has_many :topic_followings
  has_many :users, :through => :topic_followings
  has_many :taggings
  
  #this will use the name instead of id (/topics/name) instead of (/topics/id)
  def to_param
      "#{name.parameterize}"
  end
  
  
  
end
