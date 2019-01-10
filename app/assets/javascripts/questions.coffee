# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  questionForm = $("#question_form")
  addQuestionBtn = $("#add_question_btn")
  questionsList = $(".questions-list")

  addQuestionBtn.on 'click', (e) ->
    e.preventDefault()
    questionForm.show()
    questionForm.find(".cancel-btn").one 'click', ->
      questionForm.hide()
    false

  questionForm.on 'ajax:success', (e, data, status, xhr) ->
    App.utils.successMessage(data?.message)
    window.location.href = "/questions/#{data.question.id}"

  questionForm.on 'ajax:error', App.utils.ajaxErrorHandler

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      @perform 'follow'
  ,

    received: (data) ->
      questionsList.append data
  })