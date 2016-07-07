$(document).ready(function () {

  var $recipients = $(".recipient");

  $('#recipient_filter_name').on("keyup", function(){
    var currentName = this.value;
    $recipients.each(function (index, recipient){
      $recipient = $(recipient);
      if ($recipient.data('name').indexOf(currentName) !== -1 ) {
        $recipient.show();
      } else {
        $recipient.hide();
      }
    });
  });

});
