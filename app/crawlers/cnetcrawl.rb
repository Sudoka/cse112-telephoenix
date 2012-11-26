#Script is able to crawl CNET professional reviews
class CNETCrawl
  
def crawl
  #Load required libraries
  require 'nokogiri'
  require 'open-uri'
  
  #Get the Source object from the DB
  source = Source.find_or_create_by_name(:cnet)
  sourceU = Source.find_or_create_by_name(:cnetUser)

  stillGoing = true
  url = "http://reviews.cnet.com/4566-6454_7-0-0.html?rpp=30"
  page = 1
  while stillGoing
    #Set and Load CNET URL
    doc = Nokogiri::HTML(open(url))
    
    #Scrape all phones and their ratings
    info = doc.xpath('//section[@class="product"]')
    stillGoing = false

    #Break down the data and add to DB
    info.each do |i|
      stillGoing = true
      p = i.xpath('div/a/h3/text()[1]')
      r = i.xpath('div/div/div/a/@data-tiptitle')
      userRev = i.xpath('div/div/span/a/@data-tiptitle')
      numUserRev = i.xpath('div/div/span/a/@data-tiptext')
      image = i.xpath('a[@class="image"]/img/@src')

      open('app/assets/images/phones'+image.to_s[image.to_s.rindex('/'),image.to_s.length], 'wb') do |file|
        file << open(image.to_s).read
      end
      puts r.to_s
      puts userRev.to_s + " with "+ numUserRev.to_s
      
      p = p.to_s.strip
      brand = p[0,p.index(" ")]
      name = p[p.index(" ")+1,p.length]
      if (r.to_s.strip != "")
        rate = Float(r.to_s[0,r.to_s.index(" ")])
      end
      if (userRev.to_s.strip != "")
        userRate = Float(userRev.to_s[0,userRev.to_s.index(" ")])
        temp = numUserRev.to_s
        userRateNum = Integer(temp[5,temp[5, temp.length].index(" ")])
      end
      
      
      phone = Phone.find_or_create_by_name_and_brand_and_imgurl(name, brand, '/assets/phones'+image.to_s[image.to_s.rindex('/'),image.to_s.length])
      if (rate != nil)  
        rating = Rating.find_or_create_by_source_id_and_phone_id(source.id, phone.id)
        rating.rating = Integer(rate*20)
        rating.save
      end
      if (userRate != nil)
        userRating = Rating.find_or_create_by_source_id_and_phone_id(sourceU.id, phone.id)
        userRating.rating = userRate*20
        userRating.number_reviews = userRateNum
        userRating.save
      end
    end
    page = page+1
    url = "http://reviews.cnet.com/4566-6454_7-0-"+page.to_s+".html?rpp=30"
  end
end
end
