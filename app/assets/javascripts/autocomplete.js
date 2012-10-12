$(document).ready(function() {
	$('#user_name').autocomplete({
		source: $('#user_name').data('autocomplete-source')
	})
	$('#event_name').autocomplete({
		source: $('#event_name').data('autocomplete-source')
	})
})