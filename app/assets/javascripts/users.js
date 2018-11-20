// $(function() {
//   $('#my-modal').on('show.bs.modal', function (e) {
//     var user_id = $(e.relatedTarget).data('user');
//     console.log(user_id);
//     var banFormAction = '/users/' + user_id + '/ban_user';
//     // $(e.currentTarget).find('input[name="ban_days"]').val(user_id);
//     $("#ban-form").attr("action", banFormAction);
//    // $(e.currentTarget).find('input[name="ban_days"]').val(user_id);
//     //var a=$(e.currentTarget).find('input[name="ban_days"]')
//     //console.log(a);
    
//   });
// });

$( document ).on('turbolinks:load', function() {
  $('#my-modal').on('show.bs.modal', function (e) {
    var user_id = $(e.relatedTarget).data('user');
    var banFormAction = '/users/' + user_id + '/ban_user';
    console.log(banFormAction);
    $("#ban-form").attr("action", banFormAction);
  });
});

//function onSearchButtonClick () 
$( document ).on('turbolinks:load', function() {
  // $("#search_input").on("focus", function(e) {
  //   console.log("dasdas");
  //   $('.dropdown-toggle_search').dropdown("toggle");
  // });
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
        if(data.length) {
          $('#search_result').empty();
          //let divider = "<li class="dropdown-header">People</li> <li class="divider"></li>"
          console.log(data);
          for ( let obj of data ){
            let html_link = '<li><a href=' + '/users/'+ obj.id +'>'+obj.first_name + '</a>' + '</li>';
            $('#search_result').append(html_link)
          }
          $('.dropdown-toggle_search').dropdown("toggle");
        }
      });
    }
  });
});
