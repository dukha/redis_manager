RedisManager::Application.routes.draw do
 

  #resources :redis_admins

 

  scope "(/:locale)" do
   resources :languages
   resources :whiteboard_types
   resources :whiteboards
   resources :calmapps
   resources :calmapp_versions
   resources :version_statuses
   resources :redis_databases
   resources :redis_instances
   resources :user_preferences, :only=>[:edit, :show]
   resources :translations, :except=>:show#, :only=> [:new, :index]
   match "translations/dev_new" => "translations#dev_new", :as => "dev_new_translation"
   match "translations/dev_create" => "translations#dev_create", :as => "dev_create_translation"
   #match "redis_translations/edito" => "redis_translations#edito", :as => "edito_translation"
   resources :translation_parameters, :only=> [ :new, :index]
   #match "translation_parameters/save" => "translation_parameters#save", :as => "save_translation_params"
   resources :uploads
   match "uploads/file_to_redis/:id" => "uploads#file_to_redis", :as => "to_redis"
   match "uploads/select_translation_to_redis/:id" => "uploads#select_translation_to_redis", :as => "select_to_redis"

   match "redis_databases/redis_to_yaml/:id" => "redis_databases#redis_to_yaml", :as => "redis_to_yaml"
   #get "calmapps/all_in_one_new/" => "calmapps#all_in_one_new", :as => "all_in_one_new"
   #get "calmapps/all_in_one_create" => "calmapps#all_in_one_create"
   #match "upload"
   root :to => "whiteboards#index"
  end
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
