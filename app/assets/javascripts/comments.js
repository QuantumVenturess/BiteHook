$(document).ready(function() {
	$('.myComment').live('mouseenter', function() {
		var id = $(this).attr('id');
		$('#' + id + ' .commentDelete').show();
	}).live('mouseleave', function() {
		var id = $(this).attr('id');
		$('#' + id + ' .commentDelete').hide();
	});
});