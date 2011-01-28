class RepEventsController < ApplicationController
    before_filter :authorize_access
    before_filter :check_input
  

  def new
    
    @rep_event = RepEvent.new(params[:rep_event])

    @user = User.find(session[:user_id])
    @rep_event.answer_id = params[:answer_id]
    @rep_event.author_id = params[:author_id]
    @rep_event.question_id = params[:question_id]
    @rep_event.user = @user
    @question = Question.find(params[:question_id])
    @rep_event.event_type = params[:event_type] 
    
    @check = RepEvent.where("question_id = ? and user_id = ?", @rep_event.question_id,@rep_event.user)
    if @check.blank?
          if @rep_event.author_id == @rep_event.user_id    
               redirect_to(@question, :notice => 'You cannot vote your own answers.') 
          else     
              if @rep_event.save
              redirect_to(@question, :notice => 'You have successfully voted this answer.') 
              # format.html { redirect_to(:controller =>'questions', :action => 'show', :id => params[:question_id]) }
              else
              redirect_to(:controller =>'questions', :action => 'show', :id => params[:question_id]) 
              end
          end
      else
          redirect_to(@question, :notice => 'You cannot vote more than once in this question.')          
      end      
    end
  

    
    def check_input
      if (!is_numeric? params[:question_id])
          flash[:notice] = "Naughty Boy"
          redirect_to(:controller => 'questions') 
          return false
      end
      @question = Question.find(params[:question_id])  
      if (!is_numeric? params[:answer_id]) || (!is_numeric? params[:author_id]) 
          flash[:notice] = "Naughty Boy"
          redirect_to(@question) 
          return false
      end 
      if params[:event_type] != "up" && params[:event_type] != "down"
            flash[:notice] = "Naughty Boy"
            redirect_to(@question) 
            return false
      end
    end




    def is_numeric?(obj) 
       obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
    end
end
