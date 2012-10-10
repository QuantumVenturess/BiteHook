class User < ActiveRecord::Base
	attr_accessible :name,
					:access_token,
					:first_name,
					:email,
					:facebook_id,
					:image,
					:in_count,
					:last_in,
					:last_name,
					:location,
					:slug

	has_many :events, through: :attendances
	has_many :attendances, dependent: :destroy

	has_many :comments, dependent: :destroy

	has_many :payments

	extend FriendlyId
	friendly_id :name, use: :slugged

	validates :name, presence: true

	def partial_token
		self.access_token[4] + self.access_token[8] + self.access_token[12] + self.access_token[21] + self.access_token[24]
	end

	def self.authenticate_with_remember_token(id, facebook_id, partial_token)
		user = User.find_by_id(id)
		if user
			(user.facebook_id == facebook_id && user.partial_token == partial_token) ? user : nil
		else
			nil
		end
	end

	def attending?(event)
		Attendance.find_by_user_id_and_event_id(self, event) ? true : false
	end
end