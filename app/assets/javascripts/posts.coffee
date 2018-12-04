@postsSetup = () ->
  $("form").attr({autocomplete: "off", autocorrect: "off"})

  #いいねボタン
  $(".post-menu .like-button").on 'click', (e) ->
    #フォームを送信
    Rails.fire($(this).parents("form")[0], 'submit')
    #ボタンを無効化
    $(this).attr("disabled", true)

  #いいねボタンクリック時
  $(".liked-users-button").on 'click', (e) ->
    #フォームを送信
    Rails.fire($(this).parents("form")[0], 'submit')

  $("#feed-items .liked-users-button").on 'click', (e) ->
    #いいねしたユーザーを表示するmodal
    $('#liked-users').modal()

  #他のコメントを表示ボタンクリック時
  $(".show-more-comments-button").on 'click', (e) ->
    #フォームを送信
    Rails.fire($(this).parent()[0], 'submit')

  #コメント送信ボタンクリック時
  $(".comment-button").on 'click', (e) ->
    #フォームを送信
    Rails.fire($(this).parents("form")[0], 'submit')

  #コメント送信時
  $("[id^=comment-form-]").on 'submit', (e) ->
    #ボタンを無効化
    $(this).find(".comment-button").attr("disabled", true)

  #最初はコメント送信ボタンを無効化
  $(".comment-button").attr("disabled", true)

  #コメント入力フォームの文字入力時
  $("[id^=comment-content-]").on 'keyup', (e) ->
    #空だったら送信ボタンを無効化
    if $(this).val().trim() != ""
      $(this).next().removeAttr("disabled")
    else
      $(this).next().attr("disabled", true)

  #コメント削除ボタンクリック時
  $(".comment-delete-button").on 'click', (e) ->
    #フォームを送信
    Rails.fire($(this).parents("form")[0], 'submit')

  #投稿詳細ボタンクリック時
  $(".post-detail-button").on 'click', (e) ->
    #フォームを送信
    Rails.fire($(this).parents("form")[0], 'submit')
    #投稿詳細を表示するmodal
    $('#post-detail').modal()

$(document).on 'turbolinks:load', ->
  postsSetup()
