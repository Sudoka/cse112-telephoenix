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
  showDelay = 500
  showTimer = null
  hideTimer = null
  
  $('#phones span img').live('mouseover',
  ->
    if hideTimer       
       clearTimeout(hideTimer)
    if showTimer       
       clearTimeout(showTimer)
   
    win = $(this).parent().parent().siblings('div')
    td = $(this)
    td = $(this).parent()
    pos = td.offset()
    width = td.width()    
    win.css({
      left: (pos.left+width)+'px';
      left: pos.left;
      top:(pos.top)+'px';
    })
    showTimer = setTimeout ->     
      win.animate({opacity:1, height:'show'}, "normal")
    , showDelay  
    
    
  )

  $('#phones span img').live('mouseout',
  ->
    if showTimer       
       clearTimeout(showTimer)

    win = $(this).parent().parent().siblings('div')
    hideTimer = setTimeout ->     
   #   win.animate({opacity:0, height:'hide'}, "normal")
      win.css('display', 'none')
    , hideDelay    
  )

  $('#phones div').live('mouseover',
  ->
    clearTimeout(hideTimer) if hideTimer
   # $(this).animate({opacity:1, height:'show'}, "normal") 
    win = $(this)
    win.css('display', 'block')
  )
  
  $('#phones div').live('mouseout',
  ->
    win = $(this)
#    hideTimer = setTimeout -> 
#    win.animate({opacity:0, height:'hide'}, "fast")
    win.css('display', 'none')
#    , hideDelay   
   
  )










  
