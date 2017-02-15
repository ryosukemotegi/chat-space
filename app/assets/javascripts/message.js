$(function() {
  function buildHTML(message) {
    var html = '<div class="chat-message__header clearfix">' +
    '<p class="chat-message__name">' + message.name +
    '<p class="chat-message__time">' + message.created_at +
    '</div>' +
    '<p class="chat-message__body">' + message.body;

    if(message.image){
      html += '<br><img src="' + message.image + '">';
    }
    return html;
  }

$('#new_message').on('submit',function(e) {
  e.preventDefault();
  var fd = new FormData($("#new_message").get(0));
    $.ajax({
      type: 'POST',
      url: './messages.json',
      data: fd,
      processData: false,
      contentType: false,
      dataType: 'json'
    })
    .done(function(data) {
      var html = buildHTML(data);

      $('.chat-messages').append(html);
    })
    .fail(function() {
      alert('メッセージを入力してください');
    });
  });
});
