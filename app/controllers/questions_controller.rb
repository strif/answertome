class QuestionsController < ApplicationController
  before_filter :authorize_access, :only => [:topic_filter]

  
  # GET /questions
  # GET /questions.xml
    # This uses the with_no_answer :scope (see question model)
  def index
    # if topic filter is on, display questions that contain topics that the user is following
  if session[:topic_filter] == "On"  
    @questions = User.find(session[:user_id]).topics.map { |t| t.questions.approved.recent }.flatten.uniq if session[:user_id]
  else
    #else display all
    @questions = Question.approved.recent
  end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end
  
  
  

  
  
  
  
  
  # This uses the answered :scope (see question model)
  def with_answers
  if session[:topic_filter] == "On" and session[:user_id]
      @questions = User.find(session[:user_id]).topics.map { |t| t.questions.approved.answered.recent }.flatten.uniq
    else
      #else display all
      @questions = Question.approved.answered.recent
    end
    render(:action => "index")
  end
  
  
  # This uses the with_no_answer :scope (see question model)
  def without_answers 
  if session[:topic_filter] == "On" and session[:user_id]
      @questions = User.find(session[:user_id]).topics.map { |t| t.questions.approved.with_no_answer.recent }.flatten.uniq
    else
      #else display all
      @questions = Question.approved.with_no_answer.recent
    end
      render(:action => "index")
   end


  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    
    # find user id
    add_user_id_or_nil(session[:user_id])
    
    # find category (to be changed)
    #@category = Category.find(3)
    #@question.category = @category
    
    # current time to created_at
    @question.created_at = Time.now
    
    # state approved
    @question.status = "approved"

    respond_to do |format|
      if @question.save
        format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  def add_user_id_or_nil (session_id)
     if session_id
       @user = User.find(session[:user_id])
       return @question.user = @user
     end
   end
  

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
  
  
  #This is the topic filter function that turns suggestions on and off
  #Please check the routs as well
  def topic_filter
    referer = request.env["HTTP_REFERER"]   
    if session[:topic_filter] == "Off"
      session[:topic_filter] = "On"
    else
      session[:topic_filter] = "Off"
    end    
    respond_to do |format|
        format.html { redirect_to(referer, :notice => "Topic Filter is now: " +  session[:topic_filter]) }
    end   
  end
  
  
  

  
  
end
