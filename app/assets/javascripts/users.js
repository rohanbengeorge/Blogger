$(function() {
  $('#my-modal').on('show.bs.modal', function (e) {
    var user_id = $(e.relatedTarget).data('user');
    var banFormAction = '/users/' + user_id + '/ban_user';
    // $(e.currentTarget).find('input[name="ban_days"]').val(user_id);
    $("#ban-form").attr("action", banFormAction);
   // $(e.currentTarget).find('input[name="ban_days"]').val(user_id);
    //var a=$(e.currentTarget).find('input[name="ban_days"]')
    //console.log(a);
    
  });
});
