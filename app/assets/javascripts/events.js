$(document).ready(function() {
	// event nav waypoint
	var eventWay1 = $('.eventWaypoint1');
	var eventWay2 = $('.eventWaypoint2');
	var eventNav = $('.eventNav');
	eventWay1.waypoint(function(event, direction) {
		if (direction == 'down') {
			eventNav.addClass('fixed_50');
		}
		if (direction == 'up') {
			eventNav.removeClass('fixed_50');
		}
	})
	eventWay2.waypoint(function(event, direction) {
		if (direction == 'down') {
			eventNav.addClass('fixed');
			eventNav.removeClass('fixed_50');
		}
		if (direction == 'up') {
			eventNav.addClass('fixed_50');
			eventNav.removeClass('fixed');
		}
	})

	// to top button
	var top = $('.topButton');
	$('.toTop').live('click', function() {
		top.addClass('stopScroll');
		$('html, body').animate({ scrollTop: 0 }, 200, function() {
			top.removeClass('stopScroll');
		});
	});
	$(window).scroll(function() {
		if ($(window).scrollTop() > $(window).height() * 1 && !top.hasClass('stopScroll')) {
			top.slideDown(100);
		}
		else {
			top.slideUp(100);
		}
	})
});