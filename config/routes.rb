Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

	#Users
  get 'signup' => 'users#new'
	post 'signup' => 'users#create'
	#get 'profile' => 'users#show'
	get 'settings' => 'users#edit'
	patch 'settings' => 'users#update'
	resources :users
	resources :sessions
	#Login/Logout
	get 'login' => 'sessions#new'
	post 'login' => 'sessions#create'
	delete 'logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'posts#index'
	resources :users
	resources :account_activations, only: [:edit]
	resources :password_resets, only: [:new, :create, :edit, :update]
	resources :posts
end
