class ApplicationController < ActionController::Base
	before_filter :set_user_time_zone
	before_filter :shortly_client

	protect_from_forgery

	include FacebookHelper
	include PaymentsHelper
	include SessionsHelper
	include UsersHelper

	private

		def set_user_time_zone
			Time.zone = "Pacific Time (US & Canada)"
		end

		def shortly_client
	  		@short = Shortly::Clients::Tinyurl
	  	end
end