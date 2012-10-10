module PaymentsHelper

	def payment_form(options = {}, &block)
		access_key = "11SEM03K88SD016FS1G2"
		amazon_payments_account_id = "DKZZKGIRREWH715T2GK6XKIEV3EQVBRHE5N3DQ"
		pipeline_url = "https://authorize.payments.amazon.com/pba/paypipeline"
		html_options = { action: pipeline_url, method: :post }.merge(options)
		content = capture(&block)
		output = ActiveSupport::SafeBuffer.new
		output.safe_concat(tag(:form, html_options, true))
		output << content
		output.safe_concat(hidden_field_tag('accessKey', access_key))
		output.safe_concat(hidden_field_tag('amazonPaymentsAccountId', amazon_payments_account_id))
		output.safe_concat(hidden_field_tag('cobrandingStyle', 'logo'))
		output.safe_concat(hidden_field_tag('immediateReturn', 1))
		output.safe_concat(hidden_field_tag('processImmediate', 1))
		output.safe_concat("</form>")
	end
end