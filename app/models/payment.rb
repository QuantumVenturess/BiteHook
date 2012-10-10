class Payment < ActiveRecord::Base
	attr_accessible :user_id, :event_id

	belongs_to :user
	belongs_to :event

	validates :amount, presence: true
	validates :transaction_id, presence: true
	validates :user_id, presence: true

	def transaction_amount=(currency_and_amount)
		currency = parse(currency_and_amount).first
		if currency == 'USD'
			amount = parse(currency_and_amount).last.to_f
		else
			amount = currency.to_f
		end
		self.amount = amount unless amount == 0.0
	end

	def parse(currency_and_amount)
		@parsed ||= currency_and_amount.split
	end
end