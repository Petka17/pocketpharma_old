require 'sidekiq/web'

Pocketpharma::Application.routes.draw do

  root 'static_pages#home'

  match '/manage', 				to: 'static_pages#manage', 				via: 'get'

  match '/rls_import', 		to: 'static_pages#rls_import', 		via: 'post'
	match '/rls_normalize', to: 'static_pages#rls_normalize', via: 'post'
	match '/medlux_import', to: 'static_pages#medlux_import', via: 'post'
	match '/dsp_update', 		to: 'static_pages#dsp_update', 		via: 'post'

	resources :rls_products
	resources :products
	resources :product_groups
	resources :inns

	resources :drugstores
	resources :ds_products

	mount Sidekiq::Web, at: '/sidekiq'
	
end

  # resources :sessions,      only: [:create, :destroy, :new]
  # resources :microposts,    only: [:create, :destroy]
  # resources :relationships, only: [:create, :destroy]

  # root 'static_pages#home'

  # match '/signup',  to: 'users#new',            via: 'get'
  
  # match '/signin',  to: 'sessions#new',         via: 'get'
  # match '/signout', to: 'sessions#destroy',     via: 'delete'

  # match '/help',    to: 'static_pages#help',    via: 'get'
  # match '/about',   to: 'static_pages#about',   via: 'get'
  # match '/contact', to: 'static_pages#contact', via: 'get'