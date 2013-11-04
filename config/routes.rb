Woo::Application.routes.draw do

  get "activity/:id", to: 'general#activity'

  get "people/index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


#general


#search routes
  post "search/searchactivities"
  post "search/searchbycity"
  get "search/activitysearch"
  get "search/peoplesearch"
 
  
#conversation
  get "conversation/index"
  get "conversation/new"
  get "conversation/show"
  post "conversation/reply"
  get '/conversation/index/:id', to: 'conversation#index'
  get 'conversation/myinbox'
  get 'conversation/myoutbox'  
  post 'conversation', to: 'conversation#trash', as: :trash 
  post 'conversation/index/:id', to: 'conversation#sendmail'
  get "/contacts/failure" => "invites#failure"
  
#profile
  get 'activities/myactivities'
  get "profile/index"
  get '/profile/:id', to: 'profile#show'
  put "profile/update"


# Follow
  
  match 'follow/list' => 'follow#list'
  get "follow/ifollow"

#show all photos
  
  get "photos/index"
  match 'show' => 'photos#show', :as => :photo

#starting page
  get "start/index"
  get "start/dashboard"

#to check
  get "/activities/back_to_edit" 
  #get emails from gmail/others
    get "/invites/:provider/contact_callback" => "invites#index"

    root :to => "start#index"
   
devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } 


  # resources

    resources :profile do
      member do
        get :follow
        get :unfollow
      end
    end


    resources :albums 
    resources :activities

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
   #root :to => 'activities#index'

  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
