#Script is able to crawl CNET professional reviews
class CNETCrawl
  
  #Load required libraries
  require 'nokogiri'
  require 'open-uri'
  
  #Get the Source object from the DB
  source = Source.find_or_create_by_name(:cnet)

  #Set and Load CNET URL
  url = "http://reviews.cnet.com/4566-6454_7-0-0.html?rpp=30"
  doc = Nokogiri::HTML(open(url))
  
  #Scrape all phones and their ratings
  info = doc.xpath('//div[@class="prodInfo"]')
  
  #Break down the data and add to DB
  info.each do |i|
    p = i.xpath('a/h3/text()[1]')
    r = i.xpath('div/div/a/@data-tiptitle')
    puts r.to_s

    p = p.to_s.strip
    brand = p[0,p.index(" ")]
    name = p[p.index(" ")+1,p.length]
    if (r.to_s.strip != "")
      rate = Float(r.to_s[0,r.to_s.index(" ")])
    end

    phone = Phone.find_or_create_by_name_and_brand(name, brand)
    if (rate != nil)  
      rating = Rating.find_or_create_by_source_id_and_phone_id(source.id, phone.id)
      rating.rating = Integer(rate*20)
      rating.save
    end
  end
end
