$(document).ready(function(){
  customElements.define('component-preview', class extends HTMLElement {

    constructor() {
      super();
    }

    connectedCallback() {
    }

    buildPreview(){
      var sampleHTML = this.innerHTML;
      this.innerHTML = `
        <div class="component-preview"></div>
        <pre><code class="component-code"></code></pre>
      `;

      this.querySelector('.component-preview').innerHTML = sampleHTML;
      this.querySelector('.component-code').innerText = sampleHTML;
    }
  });
});
