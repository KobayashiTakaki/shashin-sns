$ ->
  #いいねボタン
  $(".post-menu .like-button").click (e) ->
    #フォームを送信
    Rails.fire($(this).parent()[0], 'submit')
    #ボタンを無効化
    $(this).attr("disabled", true)

  #いいねボタンクリック時
  $(".liked-users-button").click (e) ->
    #フォームを送信
    Rails.fire($(this).parent()[0], 'submit')
    #いいねしたユーザーを表示するmodal
    $('#liked-users').modal()

  #他のコメントを表示ボタンクリック時
  $(".show-more-comments-button").click (e) ->
    #フォームを送信
    Rails.fire($(this).parent()[0], 'submit')

  #コメント送信ボタンクリック時
  $(".comment-button").click (e) ->
    #フォームを送信
    Rails.fire($(this).parent()[0], 'submit')
    #inputの内容を消去
    $(this).prev().val('')
    #ボタンを無効化
    $(this).attr("disabled", true)

  #最初はコメント送信ボタンを無効化
  $(".comment-button").attr("disabled", true)

  #コメント入力フォームの文字入力時
  $("[id^=comment-content-]").on 'keyup', (e) ->
    #空だったら送信ボタンを無効化
    if $(this).val() != ""
      $(this).next().removeAttr("disabled")
    else
      $(this).next().attr("disabled", true)
