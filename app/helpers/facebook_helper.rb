module FacebookHelper

	def facebook_scope
		[
			'user_location',
			'email',
			'publish_stream'
		].join(',')
	end

	def call(id, scope, access_token)
		api_call = HTTParty.get("https://graph.facebook.com/#{id}/#{scope}?access_token=#{access_token}")
		JSON.parse(api_call.to_json)['data']
	end

	def facebook_url
		client_id = app_id
		if Rails.env.production?
			redirect_uri = "http://bitehook.com/auth"
		else
			redirect_uri = "http://localhost:3000/auth"
		end
		scope = facebook_scope
		response_type = "token"
		state = 10.times.map { rand(10) }.join('')
		"https://www.facebook.com/dialog/oauth?
		 client_id=#{client_id}
		 &redirect_uri=#{redirect_uri}
		 &scope=#{scope}
		 &state=#{state}"
	end

	def app_id
		if Rails.env.production?
			"160257407449032"
		elsif Rails.env.development?
			"154291521379396"
		end
	end

	def app_secret
		if Rails.env.production?
			"2fcd8e226b8294ec0f820781e1b494b0"
		elsif Rails.env.development?
			"afbd43b6ecd17b4d97328ed4a461ca63"
		end
	end

	def get_me(user)
		FbGraph::User.me(user.access_token)
	end
end