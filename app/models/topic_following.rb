class TopicFollowing < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic, :counter_cache => :users_count
end
