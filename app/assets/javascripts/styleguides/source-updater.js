document.addEventListener("DOMContentLoaded", function(event) { 
  var sourceUrl = document.querySelector('[data-source-src]').dataset['sourceSrc'];
  var sourceElm = document.querySelector('[data-source-tag]');

  replaceCssSource(sourceElm, sourceUrl, function(){
    configColourInputs();
    listenForConfiguratorChanges();
  });
});

function replaceCssSource(oldEm, url, callback=function(){}){
  // Sometimes the URL is flicking back and forth, just just add the listner
  // again
  if( url == oldEm.attributes['href'].value ) {
    oldEm.addEventListener("load", function(){
      callback();
    });
    return;
  }

  // create a new html element
  var cssElement = oldEm.cloneNode();
  var _oldElm = oldEm;

  cssElement.addEventListener("load", function(){
    _oldElm.parentNode.removeChild(_oldElm);
    callback();
  });

  cssElement.setAttribute("href", url);

  // Replace the new one in the palace of the old one.
  _oldElm.parentNode.insertBefore(cssElement, oldEm)
}
