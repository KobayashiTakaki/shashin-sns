$ ->
  $(".post-menu .like-button").click (e) ->
    Rails.fire($(this).parent()[0], 'submit')
    console.log('submit')
    $(this).attr("disabled", true)
