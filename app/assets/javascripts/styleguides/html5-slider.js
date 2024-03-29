function setupHTML5Slider(selector){
  selector.find("input[type=range]").tooltip({
    title: function(){
      return $(this).val() + 'rem';
    },
    trigger: 'manual'
  });
  selector.find("input[type=range]").tooltip('show');

  selector.find("input[type=range]").on('change input', function(){
    $(this).tooltip('show');
  });

}

$(document).on('turbolinks:load', function(){
  setupHTML5Slider($(document));
});
