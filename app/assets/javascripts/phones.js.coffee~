$(document).ready -> 
  $('#Ratings :checkbox').click ->   
    status = $(this).attr 'checked'
    $('#Ratings :checkbox').each ->
      $(this).attr('checked', false)
    $(this).attr('checked', status)
    $('#side_col').submit()
 
