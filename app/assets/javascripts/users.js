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
  });

  // $("#sort-dropdown-menu li").click(function() {
  //   let feed_url = $("#sort-dropdown-menu").data('feed')
  //   $("#sort-dropdown-menu li a")[0].setAttribute('href', feed_url + '?sort_type=Date');
  //   $("#sort-dropdown-menu li a")[1].setAttribute('href', feed_url + '?sort_type=Like');
  //   console.log("dddd")
  // });

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
        if(data.constructor == Array)
        {
          if(data.length) {
            $('#search_result').empty();
            //let divider = "<li class="dropdown-header">People</li> <li class="divider"></li>"
            for ( let obj of data ){
              let html_link = '<li><a href=' + '/users/'+ obj.id +'>'+obj.first_name + '</a>' + '</li>';
              $('#search_result').append(html_link)
            }
            $('#search_result').show();
            $('.dropdown-toggle_search').dropdown("toggle");
          }
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

  // function to close the serch's dropdown when out of focus
  // $("#search_input").on("focusout", function(e) {
  //   $('.dropdown-toggle_search').dropdown("toggle");
  //   $('#search_result').hide();
  // })
});
