class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_one :profile
  has_many :rep_events
  has_many :topic_followings 
  has_many :topics, :through => :topic_followings, :include => [:questions]

  
  validates :email,  
            :uniqueness => true,
            :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i },
            :length => {:minimum => 7, :maximum => 100}
  
                 
     
  validates :username,
            :uniqueness => true,
            :format => {:with => /^[A-Za-z\d_]+$/ },
            :length => {:minimum => 3, :maximum => 40}
            

  validates :password,
            :confirmation => true,
            :length => {:minimum => 5, :maximum => 40}
            
                          

                    
   attr_accessor :password
  
  # This will prevent hashed password to be injected to our system without performing the conversion
  attr_protected :hashed_password, :salt
  
  
  
  before_create :downcase_username, :create_password  
  before_update :downcase_username, :create_password_on_update
  after_save :nil_password
  before_destroy :cannot_be_deleted

  
  
  
  
  
  def to_param 
        username
  end
  
  

  def redirect_logged
    if session[:user_id]
        flash[:notice] = "You are already logged in." 
        redirect_to(:controller => 'profiles', :action => 'index') 
        return false
    end 
  end
  
  
  #note that username.downcase will down case users input
  def self.authenticate(username = "", password = "")
    user = self.find(:first, :conditions => ["username = ?", username.downcase])
    return (user && user.authenticated?(password)) ? user : nil
  end
  
  
  def authenticated?( password = "")
    self.hashed_password == User.hash_with_salt(password, self.salt)
  end
 
  
  def add_user_id_or_nil (session_id)
    if session_id
      @user = User.find(session[:user_id])
      return @question.user = @user
    else
      return 
    end
  end
  
  # Before updating any user object password will be hashed (user might update other details) This will be performed only when password is not blank.
  def create_password_on_update
    if !@password.blank?
     self.salt = User.make_salt(self.username) if self.salt.blank?
     self.hashed_password = User.hash_with_salt(@password, self.salt)
     end
  end
  
  # username will be converted to lower case
  def downcase_username
    self.username.downcase!
  end

  # Before creating any user object password will be hashed and salted
  def create_password
    self.salt = User.make_salt(self.username)
    self.hashed_password = User.hash_with_salt(@password, self.salt)
  end

  # After saving the object we want to set the password to nil for security.
  def nil_password
    @password = nil
  end
  
  # We stope the process of destroy when the object to be destroyed has id == 1 (admin)
  def cannot_be_deleted
    return false if self.id == 1
  end
  
  #---------------------------------------------------------------------------------------------------------
  
  
  private 
  def self.make_salt( string )
    return Digest::SHA1.hexdigest(string.to_s + Time.now.to_s)
  end
  
  def self.hash_with_salt(password, salt)
    return Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
                         
  
  
  
end
