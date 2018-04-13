function setupSpectrumFields(selector){
  selector.find("[type=text-color]").spectrum({
    preferredFormat: "hex",
    showInput: true,
    appendTo: '.styleguide-configurator',
    move: function(color) {
      $(this).val(color.toHexString());
      $(this).trigger('change');
    }
  });
}

$(document).on('turbolinks:load', function(){
  setupSpectrumFields($(document));
});
