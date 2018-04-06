window.cssSource = null;

$(document).ready(function(){
  customElements.define('styleguide-content', class extends HTMLElement {
    updateSource(newURL) {
      // create a new html element
      var oldElm = this.shadowRoot.querySelector('[data-source-tag]');
      var cssElement = oldElm.cloneNode();
      var _this = this;

      cssElement.addEventListener("load", function(){
        // When another CSS sheet as been requested, just remove this sheet.
        if( window.cssSource != this.href ){
          $(this).remove();
          return;
        }

        $(this.parentElement).find("[data-source-tag]").not(this).remove();
      });

      window.cssSource = newURL;
      cssElement.setAttribute("href", newURL);

      // Replace the new one in the palace of the old one.
      this.shadowRoot.querySelector('head').append(cssElement)
    }

    updateContent(newBody){
      this.shadowRoot.querySelector('body').innerHTML = newBody;
      this.shadowRoot.querySelectorAll('component-preview').forEach(function(item, index){
        item.buildPreview();
      });
    }

    constructor() {
      super();
      const shadowRoot = this.attachShadow({mode: 'open'});
      const knownClasses = [];

      shadowRoot.innerHTML = "<!DOCTYPE html>";
      shadowRoot.append( document.createElement('html') )
      shadowRoot.querySelector('html').innerHTML = "<head></head><body></body>";
      shadowRoot.querySelector('head').innerHTML = document.querySelector('#styleguide-head').innerHTML;
      shadowRoot.querySelector('body').innerHTML = this.innerHTML;

      this.shadowRoot.querySelectorAll('component-preview').forEach(function(item, index){
        item.buildPreview();
      });

      if(window.cssSource != null){
        this.updateSource(window.cssSource);
      } else {
        this.shadowRoot.querySelector('[data-source-tag]').addEventListener("load", function(){
          $(document).trigger('styleguide-o-matic:css-updated');
        });
      }
    }
  });
});
