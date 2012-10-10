class Event < ActiveRecord::Base
	attr_accessible :name,
				:price,
				:date,
				:info,
				:address_1,
				:address_2,
				:city,
				:state,
				:zip_code,
				:image1,
				:image2,
				:image3

	has_many :users, through: :attendances
	has_many :attendances, dependent: :destroy

	has_many :comments, dependent: :destroy

	has_many :payments

	extend FriendlyId
	friendly_id :name, use: :slugged

	validates :name, presence: true
end