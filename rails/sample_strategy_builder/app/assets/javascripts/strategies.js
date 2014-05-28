console.log("Loading strategies.js....");

$('#prevtab').on('click', function() {
	console.log("prevtab clicked");
	var $tabs = $('.tabs li');
    $tabs.filter('.active').prev('li').find('a[data-toggle="tab"]').tab('show');
});

$('#nexttab').on('click', function() {
	console.log("nexttab clicked");
	var $tabs = $('.tabs li');
    $tabs.filter('.active').next('li').find('a[data-toggle="tab"]').tab('show');
});

jQuery(document).ready(function ($) {
  $('#tabs').tab();
});