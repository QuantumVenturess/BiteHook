class AttendancesController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user

	def index
		@title = 'All Attendances'
		@attendances = Attendance.order('created_at DESC')
	end

	def new
		@title = 'New Attendance'
		@attendance = Attendance.new
	end

	def create
		user = User.find_by_name("#{params[:user_name]}")
		event = Event.find_by_name("#{params[:event_name]}")
		if user && event && Attendance.find_by_user_id_and_event_id(user.id, event.id).nil?
			Attendance.create!(user_id: user.id, event_id: event.id)
			flash[:success] = "#{user.name} is now attending #{event.name}"
		else
			flash[:error] = "Attendance was not created"
		end
		redirect_to attendances_path
	end

	def edit
		@title = 'Edit Attendance'
		@attendance = Attendance.find(params[:id])
		@user = @attendance.user
		@event = @attendance.event
	end

	def update
		user = User.find_by_name("#{params[:user_name]}")
		event = Event.find_by_name("#{params[:event_name]}")
		attendance = Attendance.find(params[:id])
		if user && event && Attendance.find_by_user_id_and_event_id(user.id, event.id).nil? && attendance.update_attributes(user_id: user.id, event_id: event.id)
			flash[:success] = "Attendance updated"
		else
			flash[:error] = "Attendance failed to update, could not find user or event with that name"
		end
		redirect_to attendances_path
	end

	def destroy
		Attendance.find(params[:id]).destroy
		flash[:success] = 'Attendance deleted'
		redirect_to attendances_path
	end
end