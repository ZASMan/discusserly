Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

	#Users
  get 'signup' => 'users#new'
	post 'signup' => 'users#create'
	#Account Settings Just for Email and Password
	get 'account_settings' => 'users#edit'
	patch 'settings' => 'users#update'
	#Login/Logout
	get 'login' => 'sessions#new'
	post 'login' => 'sessions#create'
	delete 'logout' => 'sessions#destroy'
	#Banned Users Redirect
	get 'forbidden' => 'application#forbidden'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'posts#index'
	#Custom RESTful action since there is an "update account settings"
	#And update profile settings
	resources :sessions
	resources :users
	resources :account_activations, only: [:edit]
	resources :password_resets, only: [:new, :create, :edit, :update]
	resources :profiles, only: [:edit, :update, :show]
	resources :posts
end
