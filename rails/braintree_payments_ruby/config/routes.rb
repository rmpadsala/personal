BraintreePaymentsRuby::Application.routes.draw do
  devise_for :algofast_users
  #get "static_pages/home"  
  #get "static_pages/about"
  #get "static_pages/contact"
  #get "static_pages/help"

  root :to => "static_pages#home"
  match "/help", to: "static_pages#help", via: 'get'
  match "/about", to: "static_pages#about", via: 'get'
  match "/contact", to: "static_pages#contact", via: 'get'

  # customer routes
  resources :customer, :only => [:new, :edit]
  match 'customer/confirm' => 'customer#confirm', 
        via: 'get', :as => :confirm_customer

  # strategies routes
  resources :strategies, :only => [:new]

  # subscriptions routes
  match "/subscriptions/info", to: "subscriptions#info", via: 'get',
        as: 'info_subscription'
  resources :subscriptions

  # credit_card_info routes
  match 'credit_card_info/confirm', to: "credit_card_info#confirm", via: 'get',
        as: "confirm_credit_card_info"
  resources :credit_card_info, :only => [:edit]

  resources :strategy_records

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
