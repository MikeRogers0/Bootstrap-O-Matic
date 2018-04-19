function updateCSSFromForm(){
  var sourceUrl = document.querySelector('[data-source-src]').dataset['sourceSrc'];
  var sourceQuery = $('.styleguide-configurator form').serialize();
  document.querySelector('styleguide-content').updateSource(sourceUrl + '?' + sourceQuery);
  document.querySelector('styleguide-content').rebuildPreviews();

  buildEmbed(sourceQuery);
}

function buildEmbed(sourceQuery){
  var sourceUrl = document.querySelector('[data-source-src]').dataset['sourceSrc'];
  var sourceHtmlSample = document.querySelector('#html-sample-template').innerHTML.trim();
  var sourceScssUrl = document.querySelector('[data-source-scss]').dataset['sourceScss'];
  var sourcePreviewUrl = document.querySelector('[data-source-preview]').dataset['sourcePreview'];

  sourceHtmlSample = sourceHtmlSample.replaceVariables({
    '%{styleguide.url}': sourcePreviewUrl + '?' + sourceQuery,
    '%{styleguide.css_url}': sourceUrl + '?' + sourceQuery,
  });

  $('.styleguide-configurator .html-sample').val(sourceHtmlSample);
  $('.styleguide-configurator .scss-file').attr('href', sourceScssUrl + '?' + sourceQuery);
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
  buildEmbed(document.location.search.replace('?', ''));

  $('.styleguide-configurator form').on('change', function(){
    clearTimeout(updateCSSTimeout);
    updateCSSTimeout = setTimeout(function(){ updateCSSFromForm() }, 50);
  });
});
