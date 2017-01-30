# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#message-button').on 'click', (event) ->
    receiverId = $('#receiver-id').val()
    message = { type: 'text', text: $('#message-text').val() }
    App.talk.send_message receiverId, message
    $('#message-text').val('')
    event.preventDefault()

