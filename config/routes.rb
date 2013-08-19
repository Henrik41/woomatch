Woo::Application.routes.draw do
  get "conversation/index"

  get "conversation/new"

  get "conversation/show"

  get "profile/index"

  resources :profiles


  resources :activityavatars


  resources :albums


  resources :activities

  get "photos/index"
  get "test/index"

  get "start/index"
  get '/conversation/index/:id', to: 'conversation#index'
  get '/profile/:id', to: 'profile#show'
  put "profile/update"
  post 'conversation/index/:id', to: 'conversation#sendmail'
  get 'conversation/myinbox'
 devise_for :users
 

 
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
   match 'show' => 'photos#show', :as => :photo
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   #root :to => 'activities#index'
   get "/invites/:provider/contact_callback" => "invites#index"
   get "/contacts/failure" => "invites#failure"
   get "/activities/back_to_edit" 
   root :to => "activities#index"
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
