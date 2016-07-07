$(document).ready(function () {

  var $users = $(".user");

  $('#user_filter_name').on("keyup", function(){
    var currentName = this.value;
    $users.each(function (index, user){
      $user = $(user);
      if ($user.data('name').indexOf(currentName) !== -1 ) {
        $user.show();
      } else {
        $user.hide();
      }
    });
  });

});
