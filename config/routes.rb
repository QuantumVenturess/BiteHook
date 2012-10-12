Bitehook::Application.routes.draw do

	resources :attendances
	resources :comments, only: [:create, :destroy]
	resources :events do
		member do
			get :attend
			get :permalink
		end
	end
	resources :payments, only: :index
	resources :users

	# Events
	match 'upcoming' => 'events#upcoming', as: 'upcoming'
	match 'event-list' => 'events#event_list', as: 'event_list'

	# Pages
	root to: 'pages#home'
	match 'about' => 'pages#about', as: 'about'
	match 'test' => 'pages#test', as: 'test'

	# Payments
	match 'confirm_payment/:event_id' => 'payments#confirm_payment', as: 'confirm_payment'

	# Sessions
	match 'auth' => 'sessions#auth', as: 'auth'
	match 'sign-out' => 'sessions#destroy', as: 'sign_out'

	# Users
	match 'user-list' => 'users#user_list', as: 'user_list'

	# 404
	match '*url' => 'pages#not_found', as: 'not_found'
end