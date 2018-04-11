function addIndexToTemplate(template, extra_randomness){
  var timestamp = "0" + Date.now() + "0" + extra_randomness;
  template = template.replace(/NEW_RECORD/g, timestamp);

  return template;
}

$(document).on('turbolinks:load', function(){
  $('[data-append-template]').on('click', function(e){
    e.preventDefault();
    var template = $($(this).data('append-template')).html();
    $($(this).data('append-to')).append( addIndexToTemplate(template, Math.floor((Math.random() * 10000) + 1)) );
  });

  $('[data-remove-parent]').on('click', function(e){
    e.preventDefault();
    $(this).parents($(this).data('remove-parent')).remove();
  });
});
