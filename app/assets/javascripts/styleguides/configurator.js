function updateCSSFromForm(){
  var sourceUrl = document.querySelector('[data-source-src]').dataset['sourceSrc'];
  var sourceQuery = $('.styleguide-configurator form').serialize();
  document.querySelector('styleguide-content').updateSource(sourceUrl + '?' + sourceQuery);
  document.querySelector('styleguide-content').rebuildPreviews();

  $('.styleguide-configurator input.cdn-url').val(sourceUrl + '?' + sourceQuery);
  $('.styleguide-configurator input.yarn-package').val('yarn add styleamatic ' + sourceUrl + '?' + sourceQuery);
}

var updateCSSTimeout = null;

function listenForConfiguratorChanges(selector){
  selector.find('input[type=color]').on('input', function(){
    $(this).parents('form').trigger('change');
  });

  selector.find('select, input[type=text]').on('change', function(){
    $(this).parents('form').trigger('change');
  });

  selector.find('input[type=text]').on('keyup', function(){
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
