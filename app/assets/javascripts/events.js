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
})