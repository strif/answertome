class ProfilesController < ApplicationController
 
 # This action displays the logged user's profile
 def index  
  if session[:user_id].blank?  # If user not logged in redirect to login page
    flash[:notice] = "Please Login First"
    redirect_to(:controller => 'users', :action =>'login')   
  else    
   @user = User.find(session[:user_id]) # user object initialized by id
   # if user profile is not found go to new
      if @user.profile.blank?
        flash[:notice] = "No profile found! Create one !"                                   
        # redirect_to(:action => 'new')                                  
      else # else show logged user profile
        @profile = Profile.find(session[:user_id])  
        @questions = @user.questions.approved.recent
        render(:controller => 'profiles', :action => 'index')       
      end
  end
 end
 
 
 def questions_by_user
 
 end
 
  # This action displays the public profile of a given user
  def show
      if User.find_by_username(params[:username])
           @user = User.find_by_username(params[:username])
            @profile = @user.profile 
            @questions = @user.questions
             respond_to do |format|
              format.html # show.html.erb
              format.xml  { render :xml => @profile }
              end
      else
        flash[:notice] = "No such user"   
        render(:controller => 'profiles', :action => 'show') 
      end                
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(session[:user_id])
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @user = User.find(session[:user_id])
    @profile = Profile.new(params[:profile])
    @profile.user = @user
   
    
    # @question = Question.find(params[:question_id])
    # @user = User.find(session[:user_id])
    # @answer = Answer.new(params[:answer])
    # @answer.created_at = Time.now
    # @answer.question = @question
    # @answer.user = @user
    
    # @profile = Profile.new(params[:profile])
    # @profile.id = session[:user_id]
    # user.profile.create(params[:profile])
    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find(session[:user_id])
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        # format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
          format.html { redirect_to(:controller =>'profiles', :action => 'index',  :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end
