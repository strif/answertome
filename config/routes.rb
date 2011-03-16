Qna::Application.routes.draw do
  
  
  #static page roots
  match 'about' =>'static#about'
  match 'contact' =>'static#contact'
  match 'privacy' =>'static#privacy'
  match 'help' =>'static#help'
  match 'search' =>'questions#search', :as => "search"
  match 'topic_search' =>'topics#search', :as => "topic_search"
  
  
  resources :users , :path => "member" do
    collection do
     get :new
     get :login
     get :logout
     get :edit, :path => "update_settings"
     post :send_login
    end
  end
   

  resources :questions, :path_names => { :new => 'ask' } do
   resources :answers
    collection do     
      get :with_answers
      get :without_answers
    end
  end
  
 
   
  resources :profiles, :path => "profile" do
    collection do
      get :edit
    end
  end   

   
   
  # match 'users/' => 'users#index', :as => :index
  # match 'users/login' => 'users#login'
  # match 'users/logout' => 'users#logout'
  # match 'users/send_login' => 'users#send_login'
  # match 'users/edit' => 'users#edit'
  # match 'profile/' => 'profiles#index'
  # match 'profile/edit' => 'profiles#edit'
  # match 'profiles/check' => 'profiles#check'
  # match 'profile/:id' => 'profiles#show'

    
     
    # match 'questions/answered_questions' => 'questions#answered_questions'
    # match 'questions/with_no_answers' => 'questions#with_no_answers'
    # 

  
        
  
    
  
  # resources :question_topics
  # resources :attachings
  # resources :question_followings

  # resources :user_followings
  # resources :messages
  # resources :infos
  # resources :datatypes
  # resources :settings
    
  resources :rep_events
  resources :topics
  resources :topic_followings
  
  
  # resources :categories
  # resources :comments
   resources :answers
   resources :questions

  # 
  

      #   match 'users/index' => 'users#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "questions#home"

  # easy url re-writes
  match 'register' =>'users#new'
  match 'login' =>'users#login' 
  match 'logout' =>'users#logout' 
  match 'topic_filter' =>'questions#topic_filter', :as => "topic_filter"  
  match 'answer_sort' =>'answers#answer_sort', :as => "answer_sort"  
  match ':username' =>'profiles#show', :as => "profile"
  match ':topics:name' =>'topics#show'

  

  
  # See how all your routes lay out with "rake routes"
 
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'
end


