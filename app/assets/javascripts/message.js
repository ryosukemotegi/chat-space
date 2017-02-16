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
    return $('<li class="chat-message">').append(html);
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
// message.indexを表示する
function pageupdate(){
  var currentUrl = document.location.pathname
  var messagesIndex = new RegExp(/\/groups\/\d+\/messages/)
    //もし今いるページがgroups/group_id/messages(messages.index)だったら
  if(currentUrl.match(messagesIndex)){
    // Ajaxを記述
    $.ajax({
      type: 'GET',
      url: currentUrl + '.json',
      processData: false,
      contentType: false,
      dataType: 'json'
    })
    // ajax 成功時にメッセージ一覧を表示
    .done(function(data){
      //メッセージ数(.chat-messageの要素数)をカウント
      var messagesCount = $('.chat-message').length;
      var dataLength = data.message.length;
      // 追加されたメッセージ(現在のメッセージ数よりも多い部分)を表示
      for (var i = messagesCount; i < dataLength; i = i + 1) {
        var html = buildHTML(data.message[i]);
        // index画面にメッセージを表示する
        $('.chat-messages').append(html);
      }
    })
    .fail(function(){
      alert('error');
    });
  }
}
  setInterval(pageupdate, 5000)
});
