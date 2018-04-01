function configColourInputs(){
  var colorInputs = document.querySelectorAll('[data-value-src]');

  colorInputs.forEach(function(item, index) {
    var color = getComputedStyle(document.querySelector('styleguide-content').shadowRoot.querySelector("body")).getPropertyValue(item.dataset['valueSrc']).trim();
    if( color != '' ) {
      item.value = color;
    }
  });
};

function configFontInputs(){
  // Get and select the font size base
  var htmlFontSizeBase = getComputedStyle(document.querySelector('styleguide-content').shadowRoot.querySelector("html")).getPropertyValue('font-size');
  var bodyFontSizeBase = getComputedStyle(document.querySelector('styleguide-content').shadowRoot.querySelector("body")).getPropertyValue('font-size');
  var fontSizeBase = parseInt(bodyFontSizeBase) / parseInt(htmlFontSizeBase) + "rem";
  $('[name="variables[font-size-base]"]').val(fontSizeBase);

  // Set the font types also
  var fontFamilySansSerif = getComputedStyle(document.querySelector('styleguide-content').shadowRoot.querySelector("body")).getPropertyValue('--font-family-sans-serif').trim();
  $('[name="variables[font-family-sans-serif]"]').val(fontFamilySansSerif);

  var fontFamilyMonospace = getComputedStyle(document.querySelector('styleguide-content').shadowRoot.querySelector("body")).getPropertyValue('--font-family-monospace').trim();
  $('[name="variables[font-family-monospace]"]').val(fontFamilyMonospace);
}

function updateCSSFromForm(){
  var sourceUrl = document.querySelector('[data-source-src]').dataset['sourceSrc'];
  document.querySelector('styleguide-content').updateSource(sourceUrl + '?' + $('.styleguide-configurator form').serialize());
}

var updateCSSTimeout = null;

function listenForConfiguratorChanges(){
  var inputs = document.querySelectorAll('.styleguide-configurator input, .styleguide-configurator select');

  $('.styleguide-configurator input[type=color]').on('input', function(){
    clearTimeout(updateCSSTimeout);
    updateCSSTimeout = setTimeout(function(){ updateCSSFromForm() }, 50);
  });

  $('.styleguide-configurator select').on('change', function(){
    clearTimeout(updateCSSTimeout);
    updateCSSTimeout = setTimeout(function(){ updateCSSFromForm() }, 50);
  });

};

$(document).on('turbolinks:load', function(){
  listenForConfiguratorChanges();
});

$(document).on('styleguide-o-matic:css-updated', function(){
  configColourInputs();
  configFontInputs();
});
