window.cssSource = null;

$(document).ready(function(){
  customElements.define('styleguide-content', class extends HTMLElement {
    constructor() {
      super();
      const shadowRoot = this.attachShadow({mode: 'open'});

      shadowRoot.innerHTML = "<!DOCTYPE html>";
      shadowRoot.append( document.createElement('html') )
      shadowRoot.querySelector('html').innerHTML = "<head></head><body></body>";
      shadowRoot.querySelector('head').innerHTML = document.querySelector('styleguide-head').innerHTML;
      shadowRoot.querySelector('body').innerHTML = this.innerHTML;

      this.innerHTML = '';

      if(window.cssSource != null){
        replaceCssSource(this.shadowRoot.querySelector('[data-source-tag]'), newURL);
      }
    }

    updateSource(newURL){
      window.cssSource = newURL;
      replaceCssSource(this.shadowRoot.querySelector('[data-source-tag]'), newURL);
    }
  });
});
