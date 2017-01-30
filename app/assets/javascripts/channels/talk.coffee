App.talk = App.cable.subscriptions.create "TalkChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    receiverId = $('#receiver-id').val()
    return if receiverId != data['receiver_id']
    $('#timeline').append data['message']
    if $('#timeline').children().size() > 5
      $('#timeline').children().first().remove()

  send_message: (receiverId, message) ->
    @perform 'send_message', receiver_id: receiverId, message: message

