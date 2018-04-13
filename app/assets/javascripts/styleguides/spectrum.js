$(document).on('turbolinks:load', function(){
  $("[type=text-color]").spectrum({
    preferredFormat: "hex",
    showInput: true,
    appendTo: '.styleguide-configurator',
    move: function(color) {
      $(this).val(color.toHexString());
      $(this).trigger('change');
    }
  });

});
