$(document).on('turbolinks:load', function() {
  $('input.select-on-clickable').on('click', function(){
    $(this).select();
  });
});
