$(document).on('turbolinks:load', function() {
  $('.select-on-clickable').on('click', function(){
    $(this).select();
  });
});
