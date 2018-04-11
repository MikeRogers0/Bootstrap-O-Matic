$(document).ready(function(){
  customElements.define('component-preview', class extends HTMLElement {

    constructor() {
      super();
    }

    buildPreview(){
      var sampleHTML = '';

      if(this.querySelector('.variabled-sample-html') != null){
        var variabledSampleHTML = this.querySelector('.variabled-sample-html').innerHTML.trim();

        // Get all the current variables
        var knownVaribles = $.makeArray($('#required-colours-fields input[type=text], #optional-colours-fields input[type=text]').map(function(){
          return $(this).val();
        })).filter(String);

        knownVaribles.forEach(function(item, index){
          sampleHTML += variabledSampleHTML.replaceVariables({
            '%{colour}': item.parameterize(),
            '%{colour.capitalize}': item.capitalize(),
          }) + "\n";
        });
      }

      if(this.querySelector('.sample-html') != null){
        sampleHTML += this.querySelector('.sample-html').innerHTML.trim();
      }

      if(this.querySelector('.component-preview') == null){
        this.innerHTML += `
          <div class="component-preview"></div>
          <pre><code class="component-code"></code></pre>
        `;
      }

      this.querySelector('.component-preview').innerHTML = sampleHTML.trim();
      this.querySelector('.component-code').innerText = sampleHTML.trim();

      $(this.querySelector('.component-preview')).find('[data-dismiss="alert"]').on('click', function(){
        $(this).parents('.alert').alert('close');
      });
    }
  });
});
