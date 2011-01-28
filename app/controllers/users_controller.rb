class UsersController < ApplicationController
  before_filter :authorize_access, :except => [:index, :new, :login, :send_login, :create]
  before_filter :redirect_logged, :only => [:new, :login]

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  #-------------------------LOGIN_RELATED------------------------------
  # def new
  #   @user = User.new
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @user }
  #   end
  # end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

 
  def send_login
    found_user = User.authenticate(params[:username], params[:password])
    if found_user
      found_user.last_login = Time.now
      found_user.save
      session[:user_id] = found_user.id
      flash[:notice] = "You are now logged in."
      redirect_to(:controller => 'profiles', :action => 'index')
      
    else
      flash[:notice] = "Username/password combination incorrect. Please make sure your caps lock key is off and try again."
      redirect_to(:controller => 'users', :action => 'login')
    end
  end
  
  def login
    
  end


  
  
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "You are now logged out "
    redirect_to(:action => 'login')
  end
  
  
 
  #--------------------------------REGISTER-------------------------------
   def create
   @user = User.new(params[:user])
   @user.username.downcase!
   @user.created_at = Time.now
   @user.usergroup = "members"
   respond_to do |format|
     if @user.save
       session[:user_id] = @user.id
       format.html { redirect_to(@user, :notice => 'User was successfully created.') }
       format.xml  { render :xml => @user, :status => :created, :location => @user }
     else
       format.html { render :action => "new" }
       format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
   end
     end
   end



 
 
  #---------------------------DEAFULT------------------------
  # to be removed as such actions will go to profile 
  # def show
  #   @user = User.find_by_username(params[:username])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @user }
  #   end
  # end


  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(session[:user_id])
  end
  

  def update
    @user = User.find(session[:user_id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(:controller => 'profiles', :action => 'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end



  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
