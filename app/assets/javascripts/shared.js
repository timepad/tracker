function init_tooltips() {
  $('#admin_area_tooltip').tooltip({ container: 'a'});

  $('#user_profile_tooltip').tooltip({ container: 'a'});

  $('#logout_tooltip').tooltip({ container: 'a'});
}

$(function() {
  init_tooltips();
});

$(window).bind('page:load', function() {
  init_tooltips();
})
