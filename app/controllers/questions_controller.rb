class QuestionsController < ApplicationController
  
  # GET /questions
  # GET /questions.xml
    # This uses the with_no_answer :scope (see question model)
  def index
    # if user is logged on, display questions that contain topics that the user is following
  if session[:user_id]
    @questions = User.find(session[:user_id]).topics.map { |t| t.questions.approved.recent }.flatten.uniq
  else
    #else display all
    @questions = Question.approved.recent

  end
  #@usertopics = User.find(2).topics
  #@questions2 = Question.all
  #@questions = @usertopics.@questions2
  
#  @questions = @user.questions
  
  #<%= @questions = topic.questions %>
  #<%= render :partial => @questions%>
  
  
   # @usertags = User.find(session[:user_id]).topics

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end
  
  
  
  # This uses the answered :scope (see question model)
  def with_answers
     @questions = Question.answered
    render(:action => "index")
  end
  
  
  # This uses the with_no_answer :scope (see question model)
  def without_answers    
      @questions = Question.with_no_answer
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
end
