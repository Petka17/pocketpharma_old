Pocketpharma::Application.routes.draw do

  root 'static_pages#home'

	resources :rls_products do
		collection { post :import }
	end

	resources :drugstores do
		collection { post :import }
	end

	match '/rls_product_list', to: 'rls_products#index', via: 'get'

end
