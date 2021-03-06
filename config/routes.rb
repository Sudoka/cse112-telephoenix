Telephoenix::Application.routes.draw do

  match 'auth/:provider/callback', to: 'omniauth#create'
  match 'auth/failure', to: redirect('/')
#  match 'signout', to: 'omniauth#destroy', as: 'signout'
  


  get "static_pages/about"

  get "static_pages/contact"

  get "static_pages/home"

  resources :likes


  get "user/register"
  post "user/register"

  get "user/login"
  post "user/login"

  get "user/logout"

  get "user/delete"

  get "user/edit"


  get "user/forget_password"   
  post "user/forget_password"

  get "user/upgrade"
  post "user/upgrade"

  get "user/indexMod"
  get "user/indexAdmin"
  
 # get "user/:id/change_password" => 'user'
#  match 'user/:id/change_password' => 'user#change_password', :via => [:get, :post]
  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :user do
    member do
      get 'change_password'
      post 'change_password'
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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
resources :phones do
    resources :reviews do
        resources :comments
    end
end

match "/review_likes/new/:review_id/:value"=> "review_likes#new"
resources :review_likes

resources :user


root to: redirect('/phones')
end
