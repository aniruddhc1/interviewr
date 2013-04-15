Interviewr::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :sessions

  match 'end' => 'sessions#destroy', :as => :end
  match 'done' => 'interviewee_sessions#destroy', :as => :done
  match 'interviewer' => 'sessions#show', :as => :current_session
  match 'interviewee' => 'interviewee_sessions#show'
  match 'busy' => 'static#busy', :as => :busy
  match 'no_session' => 'static#no_session', :as => :no_session
  match 'disconnected' => 'static#disconnected', :as => :disconnected
  match ':random' => 'interviewee_sessions#new', :as => :new_interviewee_session
  match 'sess/:random' => 'interviewee_sessions#create', :as => :link_session
  match 'sessions' => 'static#no_session'
  match 'sessions/:foo' => 'static#no_session'


  root :to => 'sessions#new'
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
  # match ':controller(/:action(/:id))(.:format)'
end
