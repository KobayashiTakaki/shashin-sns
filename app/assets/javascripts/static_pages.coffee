$ ->
  $(".post-menu .like-button").click (e) ->
    Rails.fire($(this).parent()[0], 'submit')
    $(this).attr("disabled", true)

  $(".liked-users-button").click (e) ->
    Rails.fire($(this).parent()[0], 'submit')
    $('#liked-users').modal()
  # $('#liked-users').on 'shown.bs.modal', (e) ->
  #   Rails.fire(e.relatedTarget.parentNode, 'submit')
  #
  # $('#liked-users').on 'hidden.bs.modal', (e) ->
  #   $(this).find(".user-list").empty()
