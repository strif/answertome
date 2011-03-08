class TopicFollowingsController < ApplicationController
 before_filter :authorize_access
 
 #This is the method that will attach a topic to a user when user will press the follow topic link   
  def new    
    @topic_follow = TopicFollowing.new
    @user = User.find(session[:user_id])
    @topic = Topic.find(params[:topic_id])
    @topic_follow.user = @user
    @topic_follow.topic = @topic  
    # @find = TopicFollowing.where("topic_id = ?" ,87)   
   # @user.topic_followings.delete(find)
    
   # @following = TopicFollowing.where("user_id = ? and topic_id = ?", session[:user_id], params[:topic_id])
    @following = TopicFollowing.find_by_user_id_and_topic_id(@user,@topic)
       
    #@tfollowing = @user.topic_followings(@topic)
    if @following      
    @following.destroy
    redirect_to(@topic, :notice => "I hope you find some cool new topics :(") 
    else
      if @topic_follow.save
       redirect_to(@topic, :notice => "You are now following it") 
       # format.html { redirect_to(:controller =>'questions', :action => 'show', :id => params[:question_id]) }
      else
       redirect_to(:controller =>'topics', :action => 'index') 
      end       
    end  
  end
    
    
    
end
