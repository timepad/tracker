function init_tooltips() {
  if ($('.has_tooltip').size() > 0) {
    $('.has_tooltip').tooltip({ container: 'a'});
  }
}

$(function() {
  init_tooltips();
});

$(window).bind('page:load', function() {
  init_tooltips();
})
