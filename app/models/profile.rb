class Profile < ActiveRecord::Base
  set_primary_key 'user_id'
  belongs_to :user
  
    validates :first_name,  
              :length => {:maximum => 60}

    validates :last_name,  
              :length => {:maximum => 60}
              
    validates :location,  
              :length => {:maximum => 50}

    validates :gender,  
              :length => {:maximum => 6}
              
 

end
