require 'sidekiq/web'

Pocketpharma::Application.routes.draw do

  root 'static_pages#home'

  match '/manage', 				to: 'static_pages#manage', 				via: 'get'

  match '/rls_import', 		to: 'static_pages#rls_import', 		via: 'post'
	match '/rls_normalize', to: 'static_pages#rls_normalize', via: 'post'
	match '/medlux_import', to: 'static_pages#medlux_import', via: 'post'
  match '/dsp_update',    to: 'static_pages#dsp_update',    via: 'post'
  match '/fill_score',    to: 'static_pages#fill_score',    via: 'post'

	resources :rls_products

	resources :products
	resources :product_groups
	resources :inns

	resources :drugstores
	resources :ds_products do
    member do
      post 'accept', 'update_product_id'
    end
  end

	mount Sidekiq::Web, at: '/sidekiq'
	
end