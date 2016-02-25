Rails.application.routes.draw do
  get 'establishments/tests', to: 'establishments#tests'

  devise_for :users
  # get 'home/index'

  # root to: "deals#index"
  root to: "home#index"
  resources :establishments
  resources :users
  resources :deals

  resources :establishments do
    put :favorite, on: :member
  end

  # config/routes.rb
  resources :deals do
    put :favorite, on: :member
  end

  # Favorites route for showing the current user's establishments
  get '/your_establishments', to: 'establishments#your_establishments', as: :your_establishments
  get '/your_deals', to: 'deals#your_deals', as: :your_deals

  # Favorites route for favoriting establishments
  get '/favorites', to: 'establishments#favorites_page', as: :favorites_page

  # Favorites route for favoriting deals
  get '/favorite_deals', to: 'deals#favorite_deals_page', as: :favorite_deals_page


  get 'info', to: 'home#info', as: :info_page
  # get 'about' => 'home#about'


  # sending text test url
  get 'send_text_test', to: 'deals#send_text_test'

  # receiving text test url
  get 'receive_text_test', to: 'deals#receive_text_test'

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
