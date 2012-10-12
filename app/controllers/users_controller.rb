class UsersController < ApplicationController
	before_filter :authenticate
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: [:index, :user_list]

	# all users
	def show
		@user = User.find(params[:id])
		@title = @user.name
		@events = @user.events.order('date DESC')
	rescue ActiveRecord::RecordNotFound
		redirect_to current_user
	end

	# correct users
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

	# admin users
	def index
		@title = 'All Users'
		@users = User.order('name')
	end
	
	def user_list
		if Rails.env.production?
			@users = User.order(:name).where("name ILIKE ? OR first_name ILIKE ? or last_name ILIKE ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
		else
			@users = User.order(:name).where("name LIKE ? OR first_name LIKE ? or last_name LIKE ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
		end
		render json: @users.map(&:name)
	end
end