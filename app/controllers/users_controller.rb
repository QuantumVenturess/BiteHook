class UsersController < ApplicationController
	before_filter :authenticate
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :index

	def index
		@title = 'All Users'
		@users = User.order('name')
	end

	def show
		@user = User.find(params[:id])
		@title = @user.name
		@events = @user.events.order('date DESC')
	rescue ActiveRecord::RecordNotFound
		redirect_to current_user
	end

	def edit
		@user = User.find(params[:id])
		@title = 'Edit Settings'
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = 'Update successful'
			redirect_to @user
		else
			@title = 'Edit Settings'
			flash[:error] = 'Please fill in your name'
			render 'edit'
		end
	end
end