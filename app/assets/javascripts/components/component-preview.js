$(document).ready(function(){
  customElements.define('component-preview', class extends HTMLElement {

    constructor() {
      super();
    }

    getTemplate() {
      return this.querySelector('template').innerHTML.trim();
    }

    buildSimple() {
      var sampleHTML = '';

      if(this.querySelector('.simple') == null){
        this.innerHTML += `
          <div class="simple">
            <div class="component-preview"></div>
            <pre><code class="component-code"></code></pre>
          </div>
        `;
      }

      this.querySelector('.component-preview').innerHTML = this.getTemplate();
      this.querySelector('.component-code').innerText = this.getTemplate();
    }

    buildVariabled() {
      var sampleHTML = '';
      var _template = this.getTemplate();

      this.getKnownVariables().forEach(function(item, index){
        var variableSampleElm = document.createElement('div');
        variableSampleElm.className = 'variabled-item';
        variableSampleElm.innerHTML = `
            <div class="component-preview"></div>
            <pre><code class="component-code"></code></pre>
        `;

        var variabledSample = _template.replaceVariables({
          '%{colour}': item.parameterize(),
          '%{colour.capitalize}': item.capitalize(),
        }) + "\n";

        variableSampleElm.querySelector('.component-preview').innerHTML = variabledSample;
        variableSampleElm.querySelector('.component-code').innerText = variabledSample;

        sampleHTML += variableSampleElm.outerHTML;
      });

      if(this.querySelector('.variabled') == null){
        this.innerHTML += `
          <div class="variabled">
            <div class="component-preview"></div>
            <pre><code class="component-code"></code></pre>
          </div>
        `;
      }

      this.querySelector('.variabled').innerHTML = sampleHTML.trim();
    }

    buildGroupVariabled() {
      var sampleHTML = '';
      var _template = this.getTemplate();

      this.getKnownVariables().forEach(function(item, index){
        sampleHTML += _template.replaceVariables({
          '%{colour}': item.parameterize(),
          '%{colour.capitalize}': item.capitalize(),
        }) + "\n";
      });

      if(this.querySelector('.group-variabled') == null){
        this.innerHTML += `
          <div class="group-variabled">
            <div class="component-preview"></div>
            <pre><code class="component-code"></code></pre>
          </div>
        `;
      }

      this.querySelector('.component-preview').innerHTML = sampleHTML.trim();
      this.querySelector('.component-code').innerText = sampleHTML.trim();
    }

    getKnownVariables() {
      return $.makeArray($('#required-colours-fields input[type=text], #optional-colours-fields input[type=text]').map(function(){
        return $(this).val();
      })).filter(String);
    }

    buildPreview() {
      if ( this.dataset['groupVariabled'] != undefined ) {
        this.buildGroupVariabled();
      } else if ( this.dataset['variabled'] != undefined ) {
        this.buildVariabled();
      } else {
        this.buildSimple();
      }

      $(this.querySelector('.component-preview')).find('[data-dismiss="alert"]').on('click', function(){
        $(this).parents('.alert').alert('close');
      });
    }

  });
});
