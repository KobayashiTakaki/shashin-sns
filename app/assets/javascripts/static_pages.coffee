$ ->
  $(".post-menu .like-button").click (e) ->
    Rails.fire($(this).parent()[0], 'submit')
    $(this).attr("disabled", true)

  $(".liked-users-button").click (e) ->
    Rails.fire($(this).parent()[0], 'submit')
