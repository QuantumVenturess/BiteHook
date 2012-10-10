class PagesController < ApplicationController

	def home
		@title = "BiteHook"
	end

	def about
		@title = "About BiteHook"
	end

	def test
		@title = 'Test'
		@payments = Payment.all
	end
end