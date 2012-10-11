class SessionsController < ApplicationController
	before_filter :already_signed_in, except: :destroy

	# Server side Facebook authentication
	def auth
		client_id = app_id
		if Rails.env.production?
			redirect_uri = "http://bitehook.com/auth"
		else
			redirect_uri = "http://localhost:3000/auth"
		end
		client_secret = app_secret
		code = params[:code]
		exchange = "https://graph.facebook.com/oauth/access_token?client_id=#{client_id}&redirect_uri=#{redirect_uri}&client_secret=#{client_secret}&code=#{code}"
		response = HTTParty.get(exchange)
		if response.to_s[/error/]
			flash[:error] = 'Unable to authenticate, please try again.'
			redirect_to root_path
		else
			access_token = response.to_s.split('=')[1].split('&')[0]
			api_call = HTTParty.get("https://graph.facebook.com/me?access_token=#{access_token}")
			results = JSON.parse(api_call.to_json)
			facebook_id = results['id']
			name = results['name']
			first_name = results['first_name']
			last_name = results['last_name']
			email = results['email']
			image = "http://graph.facebook.com/#{facebook_id}/picture?type=large"
			if results['location']
				location = results['location']['name']
			else
				location = results['location']
			end
			@user = User.find_by_facebook_id(facebook_id)
			if @user
				@user.update_attribute(:access_token, access_token)
				sign_in @user
				redirect_back_or upcoming_path
			else
				@user = User.new(name: name, 
							     first_name: first_name, 
							     last_name: last_name,
							     email: email,
							     image: image,
							     location: location,
							     facebook_id: facebook_id,
							     access_token: access_token)
				if @user.save
					sign_in @user
					redirect_back_or upcoming_path
				else
					flash[:error] = 'Unable to create user, please try again.'
					redirect_to root_path
				end
			end
		end
	end

	def destroy
		sign_out
		clear_return_to
		redirect_to root_path
	end
end