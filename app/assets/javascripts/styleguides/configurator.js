function updateCSSFromForm(){
  var sourceUrl = document.querySelector('[data-source-src]').dataset['sourceSrc'];
  var sourceQuery = $('.styleguide-configurator form').serialize();
  document.querySelector('styleguide-content').updateSource(sourceUrl + '?' + sourceQuery);
  document.querySelector('styleguide-content').rebuildPreviews();

  $('.styleguide-configurator input.cdn-url').val(sourceUrl + '?' + sourceQuery);
}

var updateCSSTimeout = null;

function listenForConfiguratorChanges(selector){
  selector.find('input[type=text-color]').on('input', function(){
    $(this).parents('form').trigger('change');
  });

  selector.find('select, input').on('change keyup', function(){
    $(this).parents('form').trigger('change');
  });
};

$(document).on('turbolinks:load', function(){
  listenForConfiguratorChanges( $('.styleguide-configurator') );

  $('.styleguide-configurator form').on('change', function(){
    clearTimeout(updateCSSTimeout);
    updateCSSTimeout = setTimeout(function(){ updateCSSFromForm() }, 50);
  });
});
