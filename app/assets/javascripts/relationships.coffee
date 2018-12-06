$(document).on 'turbolinks:load', ->
  $(".following-button").on 'click', (e) ->
    Rails.fire($(this).parents("form")[0], 'submit')
    #ユーザーを表示するmodal
    $('#users-modal').modal()

  $(".followers-button").on 'click', (e) ->
    Rails.fire($(this).parents("form")[0], 'submit')
    #ユーザーを表示するmodal
    $('#users-modal').modal()
