$(document).ready(function(){
  customElements.define('colour-swatches', class extends HTMLElement {

    constructor() {
      super();
    }

    getTemplate() {
      return this.querySelector('template').innerHTML;
    }

    getKnownVariablesElms() {
      return $.makeArray($('#required-colours-fields input[type=text], #optional-colours-fields input[type=text]').map(function(){
        return $(this);
      })).filter(function(item){
        return item.val();
      });
    }

    buildPreview() {
      var sampleHTML = '';
      var _template = this.getTemplate();

      this.getKnownVariablesElms().forEach(function(itemElm, index){
        var item = itemElm.val();
        var hexCode = itemElm.parents('.row').first().find('input').last().val();

        sampleHTML += _template.replaceVariables({
          '%{colour}': item.parameterize(),
          '%{colour.capitalize}': item.capitalize(),
          '%{colour.hex}': hexCode,
          '%{colour.variable}': '$' + item.toLowerCase(),
        }) + "\n";
      });

      if(this.querySelector('.colour-swatches') == null){
        this.innerHTML += `<div class="colour-swatches row"></div>`;
      }

      this.querySelector('.colour-swatches').innerHTML = sampleHTML.trim();
    }

  });
});
