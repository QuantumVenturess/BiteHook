Bitehook::Application.routes.draw do

	resources :comments, only: [:create, :destroy]
	resources :events
	resources :payments, only: :index
	resources :users

	# Events
	match 'upcoming' => 'events#upcoming', as: 'upcoming'

	# Pages
	root to: 'pages#home'
	match 'about' => 'pages#about', as: 'about'
	match 'test' => 'pages#test', as: 'test'
	match 'test2' => 'pages#test2'

	# Payments
	match 'confirm_payment/:event_id' => 'payments#confirm_payment', as: 'confirm_payment'

	# Sessions
	match 'auth' => 'sessions#auth', as: 'auth'
	match 'sign-out' => 'sessions#destroy', as: 'sign_out'

	# 404
	match '*url' => 'pages#not_found', as: 'not_found'
end