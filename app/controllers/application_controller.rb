class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :get_layout
  
  
  

  
  protected 
  
  def get_layout
    
    if false
      "member_menu"
    else
      "guest_menu"
    end
    
  end
  
  
  
  private
  def redirect_logged
    if session[:user_id]
        flash[:notice] = "You are already logged in." 
        redirect_to(:controller => 'profiles', :action => 'index') 
        return false
    end 
  end
  
  def authorize_access
    if !session[:user_id]
      flash[:notice] = "Please Log in first."
      redirect_to(:controller => 'users', :action =>'login')
      return false
    end
  end
  
  
  
end
