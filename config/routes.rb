YeahProject::Application.routes.draw do

  match '/features', :to => 'pages#features'
  match '/about', :to => 'pages#about'
  match '/contact', :to => 'pages#contact'
  match '/imprint', :to => 'pages#imprint'
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/confirm', :to => 'users#confirm_user_email_address'
  
  resources :places do
    collection do
      get 'setup_countries'
    end
  end
  # resources :realms
  
  resources :tasks
  resources :acceptance_tests
  resources :user_stories do
    resources :tasks
    resources :acceptance_tests
  end
  resources :backlogs do
    resources :user_stories
    resources :sprints
  end
  resources :projects do
    resources :backlogs
    resources :user_stories
    resources :tasks
  end
  resources :products do
    resources :projects
  end 
  resources :realms do
    resources :products
  end
  
  resources :users do 
    resources :realms do
      resources :products
    end
    resources :products do
      resources :projects
    end
    resources :projects do
      resources :tasks
    end
    member do
      get 'new_assignment', 'edit_assignments'
      post 'create_assignment'
    end
    collection do
      put 'create_credentials'
    end
  end
  resources :sessions

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
  root :to => "pages#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
