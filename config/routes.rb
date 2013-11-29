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
		collection { post :update_db }
	end

	resources :products do
		collection { post :update_db }
	end

	mount Sidekiq::Web, at: '/sidekiq'
	
end
