class AnswersController < ApplicationController
  before_filter :authorize_access
  
  # GET /answers
  # GET /answers.xml
  def index
    @answers = Answer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = Answer.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # # POST /answers
  # # POST /answers.xml
  # def create
  #   @answer = Answer.new(params[:answer])
  # 
  #   respond_to do |format|
  #     if @answer.save
  #       format.html { redirect_to(@answer, :notice => 'Answer was successfully created.') }
  #       format.xml  { render :xml => @answer, :status => :created, :location => @answer }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  def create
    @question = Question.find(params[:question_id])
    @user = User.find(session[:user_id])
    @answer = Answer.new(params[:answer])
    @answer.created_at = Time.now
    @answer.votes = 0
    @answer.question = @question
    @answer.user = @user
    if @answer.save
      flash[:notice] = 'Your answer was submitted successfully.'
      redirect_to @question
    else
      render @question
    end
   end
  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to(@answer, :notice => 'Answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end
  
  
  
  def answer_sort
    referer = request.env["HTTP_REFERER"]   
    if !session[:answer_sort]
      session[:answer_sort] = "Answer Date"
    else
      session.delete(:answer_sort)
    end    
    respond_to do |format|
      # Assigning the sort_text to some string, this cant go inside the redirect_to method
      session[:answer_sort] ? sort_text = "Answers are now sorted by date" : sort_text = "Answers are now sorted by votes"
        format.html { redirect_to(referer, :notice => sort_text ) }
    end   
  end
  
  
  
end
