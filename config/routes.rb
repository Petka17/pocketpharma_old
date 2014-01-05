require 'sidekiq/web'

Pocketpharma::Application.routes.draw do

  root 'static_pages#home'

	resources :rls_products do
		collection do 
			post :import
			post :clear_db
		end
	end

	resources :drugstores do
		collection { post :import }
	end

	resources :ds_product do
		collection do
			post :update_db
			post :get_product_group_list
		end
	end

	resources :products do
		collection { post :update_db }
	end

	resources :product_groups

	resources :inns

	mount Sidekiq::Web, at: '/sidekiq'
	
end
