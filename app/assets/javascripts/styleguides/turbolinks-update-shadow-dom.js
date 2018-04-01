function setupUpdateShadowDomListners(){

  $('a[data-turbolinks-update-shadowdom]').on('click', function(e){
    e.preventDefault();
    window.shadowDomElm = $(this).data('turbolinks-update-shadowdom'); 

    $.ajax( $(this).attr('href') ).done(function(data, textStatus, jqXHR){
      $($(document).find(window.shadowDomElm)[0].shadowRoot).find('body').html( $(data).find(window.shadowDomElm).html() );

      // FIXME:  This breaks the back Button & title is blank
      //$(document).find('title').text( $(data).find('title').text() );
      //history.pushState('Push', $(data).find('title').text(), $(this)[0].url );
    });

    return false;
  });
}

$(document).on('turbolinks:load', function(e){
  setupUpdateShadowDomListners();
});
