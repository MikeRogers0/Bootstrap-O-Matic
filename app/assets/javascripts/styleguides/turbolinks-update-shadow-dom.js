function renderShadowDomElm(data, elm) {
  var response = $(document.createElement('div')).html(data);
  $(document).find(window.shadowDomElm)[0].updateContent(response.find(window.shadowDomElm).find('> template').html())

  $(document).find('title').text( response.find('title').text() );
}

function setupUpdateShadowDomListners(){
  $('a[data-turbolinks-update-shadowdom]').on('click', function(e){
    e.preventDefault();
    window.shadowDomElm = $(this).data('turbolinks-update-shadowdom'); 

    $.ajax( $(this).attr('href') ).done(function(data, textStatus, jqXHR){
      renderShadowDomElm(data, shadowDomElm);
      var response = $(document.createElement('div')).html(data);

      history.pushState({
        'update-shadowdom-data': data,
        'update-shadowdom-elm': shadowDomElm

      }, response.find('title').text() , $(this)[0].url );
    });

    return false;
  });
}

$(document).on('turbolinks:load', function(e){
  setupUpdateShadowDomListners();
});

$(window).on('popstate', function() {
  if( history.state && history.state['update-shadowdom-data'] == undefined ){
    return;
  }
  renderShadowDomElm(history.state['update-shadowdom-data'], history.state['update-shadowdom-elm']);
});
