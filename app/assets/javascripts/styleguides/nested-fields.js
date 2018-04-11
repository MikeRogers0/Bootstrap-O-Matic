$(document).on('turbolinks:load', function(){
  $('[data-append-template]').on('click', function(e){
    e.preventDefault();
    var template = $($(this).data('append-template')).html();

    $($(this).data('append-to')).append( template.replaceVariables({
      'NEW_RECORD': Date.now() + "0" + Math.floor((Math.random() * 10000) + 1)
    }) );

    listenForConfiguratorChanges($($(this).data('append-to')).find('> div').last());
  });

  $('[data-remove-parent]').on('click', function(e){
    e.preventDefault();
    $(this).parents($(this).data('remove-parent')).remove();
    document.querySelector('styleguide-content').rebuildPreviews();
  });
});
