module ApplicationHelper


 def image_stars ( num)
    r = content_tag(:span, "")
    count = num
    while num-1 >= 0
        r = r+ image_tag("star_one.png")
        num = num -1
    end
    if num>0 && num<0.25
        r = r+ image_tag("star_zero.png")
    elsif num>=0.25 && num<0.75
        r = r+ image_tag("star_half.png")
    elsif num>=0.75 && num<1
        r = r + image_tag("star_one.png")
    end
    remain = 5- count.ceil
    if remain>0
       r = r + image_tag("star_zero.png")*remain
    end
    return r
 end




	#def toggle_like(review, user)
	#	if user.flagged?(article, :like)	
	#	link_to "Unlike"
#	else 	
#	end

end
