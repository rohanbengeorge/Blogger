$( document ).on('turbolinks:load', function() {
  // function to modify modal
  $('#my-modal').on('show.bs.modal', function (e) {
    var user_id = $(e.relatedTarget).data('user');
    var banFormAction = '/users/' + user_id + '/ban_user';
    $("#ban-form").attr("action", banFormAction);
  });
  $('#ban-form').on('submit', function (e) {
    $('#my-modal').modal('hide');
  });

  // function to show selected option in dropdown
  $(".dropdown-menu li a").click(function(){
    var selText = $(this).text();
    $(this).parents('.dropdown').find('.dropdown-toggle').val(selText);
    $(this).parents('.dropdown').find('.dropdown-toggle').dropdown('toggle');
  });
});

// $("#sort-dropdown-menu li a")[0].setAttribute('href', 'aaaaaa')
// undefined
// $("#sort-dropdown-menu li a")[0].getAttribute('href')
// "aaaaaa"
 
$( document ).on('turbolinks:load', function() {
  // function to copy feed status to sort's dropdown
  $("#feed-dropdown-menu li").click(function() {
    $("#sort-dropdown-menu").data("feed", ($(this).find('a').attr('href')));
    let feed_url = $("#sort-dropdown-menu").data('feed')
    $("#sort-dropdown-menu li a")[0].setAttribute('href', feed_url + '?sort_type=Date');
    $("#sort-dropdown-menu li a")[1].setAttribute('href', feed_url + '?sort_type=Likes');

    $("#filter-dropdown-menu li a")[0].setAttribute('href', feed_url + '?filter_type=last_day');
    $("#filter-dropdown-menu li a")[1].setAttribute('href', feed_url + '?filter_type=last_week');
    $("#filter-dropdown-menu li a")[2].setAttribute('href', feed_url + '?filter_type=last_month');
    
  });

  $("#sort-dropdown-menu li").click(function() {
    // $("#sort-dropdown-menu").data("feed", ($(this).find('a').attr('href')));
    let sort_url = ($(this).find('a').attr('href'))
    let url = sort_url.split('?')
    let param = url[1]
    if (param.includes("&")) {
      param = param.split('&')[1]
    }
    sort_url = url[0] + '?' + param

    $("#filter-dropdown-menu li a")[0].setAttribute('href', sort_url + '&filter_type=last_day');
    $("#filter-dropdown-menu li a")[1].setAttribute('href', sort_url + '&filter_type=last_week');
    $("#filter-dropdown-menu li a")[2].setAttribute('href', sort_url + '&filter_type=last_month');
    
  });

  $("#filter-dropdown-menu li").click(function() {
    let filter_url = ($(this).find('a').attr('href'))
    let url = filter_url.split('?')
    let param = url[1]
    if (param.includes("&")) {
      param = param.split('&')[1]
    }
    filter_url = url[0] + '?' + param

    console.log("in filter click");
    console.log(($(this).find('a').attr('href')))
    console.log(filter_url);
    $("#sort-dropdown-menu li a")[0].setAttribute('href', filter_url + '&sort_type=Date');
    $("#sort-dropdown-menu li a")[1].setAttribute('href', filter_url + '&sort_type=Likes');
    
  });


  // function to search
  $("#search_input").on("keyup", function(e) {
    e.preventDefault();
    let text = $('#search_input').val();
    if(text.length) {
      $.ajax({
        method: "GET",
        url: "/search/index",
        data: { search_text: text }
        })
      .done(function ( data ) {
        // if(data.constructor == Array)
        // {
          if(data.length) {
            console.log(data)
            $('#search_result').empty();
            //let divider = "<li class="dropdown-header">People</li> <li class="divider"></li>"
            if (data[0].first_name){
              for ( let obj of data ){
                let html_link = '<li><a href=' + '/users/'+ obj.id +'>'+obj.first_name + '</a>' + '</li>';
                $('#search_result').append(html_link)
              }
            }
            else{
              for ( let obj of data ){
                let html_link = '<li><a data-remote="true" href=' + '/tags/'+ obj.name +'>#'+obj.name + '</a>' + '</li>';
                $('#search_result').append(html_link)
              }
            }
            $('#search_result').show();
            $('.dropdown-toggle_search').dropdown("toggle");
          // }
        }
        else
        {
          $('#search_result').empty();
          $('#search_result').hide();
          $('.dropdown-toggle_search').dropdown('toggle');
        }
      });
    }
  });

  //  function to close the serch's dropdown when out of focus
  $("#search_input").on("focusout", function(e) {

    setTimeout(function(){ 
      $('.dropdown-toggle_search').dropdown("toggle");
      $('#search_result').hide();
    }, 500);
  })


});
