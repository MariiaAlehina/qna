$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

  $('form.new_answer').bind 'ajax.success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.resposeText)
    $('.answers').append('<p>' + answer.body + '</p>')
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.resposeText)
    $.each errors, (index, value) ->
    $('.answer-errors').html(value)