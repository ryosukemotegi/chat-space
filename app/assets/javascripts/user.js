$(function(){
  var preName;
  var preFunc;
  //ユーザーの検索リスト作成
  function buildUserList(users) {
    $(".reset-search-list").remove();
    var html = "";
    $.each(users, function(index, user) {
      html += '<div class="chat-group-user reset-search-list clearfix">' +
              '<p class="chat-group-user__name">' + user.name + '</p>' +
              '<a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="' +
              user.id + '"data-user-name="' + user.name + '">追加</a></div>';
    });
    return html;
  }
  //チャットメンバーリストの作成
  function buildMemberList(id,name){
    var html = '<div class="chat-group-user clearfix" id="chat-group-user-' + id + '">' +
              '<input type="hidden" name="group[user_ids][]" value="' + id +'">'+
              '<p class="chat-group-user__name">' + name + '</p>' +
              '<a class="user-search-remove chat-group-user__btn chat-group-user__btn--remove" data-user-id="' +
              id + '">削除</a></div>';

    return html;
  }
  //インクリメンタルサーチ
  $(document).on('keyup', '#user-search-field',function(){

    var name = $(this).val();
    var ajaxSearch = function(){
      $.ajax({
        type: 'get',
        url: '/users/search.json',
        data:{
          keyword: name
        },
        dataType: 'json'
      })
      .done(function(data) {
        var html = buildUserList(data);
        $('#user-search-result').append(html);
      })
      .fail(function() {
        alert("error!!!");
      });
    };
    if(name != preName && name.length !== 0){
      clearTimeout(preFunc);
      preFunc = setTimeout(ajaxSearch, 500);
    }
    preName = name;
  });
  //追加ボタンを押した時の処理
  $(document).on('click','.user-search-add', function(){
    var id = $(this).attr('data-user-id');
    var name = $(this).attr('data-user-name');
    $(this).parent().remove();
    var html = buildMemberList(id, name);
    $('#chat-group-users').append(html);
  });

  //削除ボタンを押した時
  $(document).on('click', '.user-search-remove', function(){
    $(this).parent().remove();
  });
});
