Woo::Application.routes.draw do


  post "search/searchactivities"
  post "search/searchbycity"
  get "conversation/index"

  get "conversation/new"

  get "conversation/show"

  get "profile/index"
  post "conversation/reply"
  

  resources :profiles
  resources :ponds

  resources :activityavatars


  resources :albums
  
get 'start/autocomplete_activity_title'


  resources :activities
  get "follow/ifollow"
  get "photos/index"
  get "test/index"
  get "search/activitysearch"
  get "search/peoplesearch"
  get "start/index"
  get '/conversation/index/:id', to: 'conversation#index'
  get '/profile/:id', to: 'profile#show'
  put "profile/update"
  post 'conversation/index/:id', to: 'conversation#sendmail'
  get 'conversation/myinbox'
  get 'conversation/myoutbox'

 post 'conversation', to: 'conversation#trash', as: :trash   
    
devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :profile do
    member do
      get :follow
      get :unfollow
    end
  end
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
   match 'show' => 'photos#show', :as => :photo
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   #root :to => 'activities#index'
   get "/invites/:provider/contact_callback" => "invites#index"
   get "/contacts/failure" => "invites#failure"
   get "/activities/back_to_edit" 
   get "start/dashboard"
   root :to => "start#index"
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
