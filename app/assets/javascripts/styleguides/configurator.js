function configColourInputs(){
  var colorInputs = document.querySelectorAll('[data-value-src]');

  colorInputs.forEach(function(item, index) {
    var color = getComputedStyle(document.querySelector("body")).getPropertyValue(item.dataset['valueSrc']).trim();
    if( color != '' ) {
      item.value = color;
    }
  });
};

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

