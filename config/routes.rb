Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # user authentication
  devise_for :users

  # You can have the root of your site routed with "root"
  root 'home#index'

	namespace :admin do
    root 'chapters#index'

		resources :pages, only: [:index, :create, :new, :edit, :update, :destroy]

		resources :chapters do
			resources :pages
		end
	end

	get 'home/:title' => 'home#index'
	get 'states/:id', to: 'states#show', as: :state
	get 'chapters/:id', to: 'chapters#show', as: :chapter
	get 'pages/:id', to: 'pages#show', as: :page


  if Rails.env.development?
    # view emails in development environment
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

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
