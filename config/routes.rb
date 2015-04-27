FitcastsApp::Application.routes.draw do
  get "favorite_videos/show"
  resources :programs
  resources :cals
  resources :logs
  resources :weights
  resources :favorites
  resources :password_resets
  resources :sessions
  resources :users
  resources :videos 
  resources :searches
 match 'static_pages/about',    to: 'static_pages#about',    via: 'get'
 match '/hangout',    to: 'searches#hangout',    via: 'get'
 match '/realfittv',    to: 'searches#realfittv',    via: 'get'
  root  'searches#new'
 match 'videos/list',    to: 'videos#list',    via: 'get'
  match 'videos/new',    to: 'videos#new',    via: 'get'
  match '/terms',    to: 'static_pages#terms',    via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/workout-routines',  to: 'searches#advanced',         via: 'get',:as => 'advanced'
  match '/trainer-search',  to: 'searches#realfittvsearch', :via => :post, :as => 'realfittvsearch'
  match '/my-videos',  to: 'searches#myvideos', :via => :get, :as => 'myvideos'
  match '/users/:id/assessment(.:format)', to: 'users#assessment', via: 'get',:as => 'assessment_user'
  match '/workout-routines/:id(.:format)', to: 'videos#show', via: 'get'
  match '/workout-plans/:id(.:format)', to: 'programs#show', via: 'get'
  match '/workout-routines/:id/favorite(.:format)', to: 'videos#favorite', via: 'put',:as => 'favorite_video'
  match '/workout-plans/:id/makemine(.:format)', to: 'programs#makemine', via: 'get',:as => 'make_mine'
  match '/workout-plans', to: 'programs#list', via: 'get',:as => 'list'
  match '/addcals', to: 'programs#addcals', via: 'get',:as => 'addcals'
  match '/nocals', to: 'programs#nocals', via: 'get',:as => 'nocals'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  post 'searches/subscribe' => 'searches#subscribe'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
