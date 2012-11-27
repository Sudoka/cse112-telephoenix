$(document).ready -> 
  ####  ----------slide checkbox
  $('#Ratings :checkbox').click ->   
    status = $(this).attr 'checked'
    $('#Ratings :checkbox').each ->
      $(this).attr('checked', false)
    $(this).attr('checked', status)
    $('#side_col').submit()
 
  $('#Brands .Brands2').hide()
  
  $('#Brands p').click ->    
    if $('#Brands p').text() == 'See more manufacturers'
       $('#Brands p').text("See less manufacturers")
    else
       $('#Brands p').text("See more manufacturers")
    $('#Brands .Brands2').slideToggle()

  ####  ----------float window
  hideDelay = 10
  hideTimer = null
  
  $('#phones span img').live('mouseover',
  ->
    if hideTimer       
       clearTimeout(hideTimer)
   
    win = $(this).parent().parent().siblings('div')
    td = $(this)
    pos = td.offset()
    width = td.width()    
    win.css({
      left: (pos.left+width)+'px';
      top:(pos.top)+'px';
    })
    win.animate({opacity:1, height:'show'}, "normal") 
    
    
  )

  $('#phones span img').live('mouseout',
  ->
    win = $(this).parent().parent().siblings('div')
    hideTimer = setTimeout ->     
      win.animate({opacity:0, height:'hide'}, "normal")
    , hideDelay    
  )

  $('#phones div').live('mouseover',
  ->
    clearTimeout(hideTimer) if hideTimer
    $(this).animate({opacity:1, height:'show'}, "normal") 
    alert 's'
  )
  
  $('#phones div').live('mouseout',
  ->
    win = $(this)
    hideTimer = setTimeout -> 
      win.animate({opacity:0, height:'hide'}, "normal")
    , hideDelay   
    alert 'o'
  )










  
